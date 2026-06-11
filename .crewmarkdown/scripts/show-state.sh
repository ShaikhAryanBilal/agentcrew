#!/usr/bin/env bash
# Render workflow state as terminal dashboard
# Reads .crewmarkdown/state/workflow.json and displays objectives, gates, logs.
# Usage: .crewmarkdown/scripts/show-state.sh
#        .crewmarkdown/scripts/show-state.sh --watch 5

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STATE_FILE="${SCRIPT_DIR}/../state/workflow.json"
WATCH=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -w|--watch) WATCH="$2"; shift 2 ;;
    *) echo "Usage: $0 [--watch N]"; exit 1 ;;
  esac
done

ESC=$'\033'
e_check='OK'
e_hour='>>'
e_empty='..'
e_block='XX'
e_doc='FN'
e_done='OK'
e_pending='..'

w() {
  local s="$1" c="${2:-}"
  if [ -n "$c" ]; then printf "${ESC}[${c}m%s${ESC}[0m" "$s"
  else printf "%s" "$s"; fi
}

wl() {
  local s="${1:-}" c="${2:-}"
  w "$s" "$c"; printf '\n'
}

obj_icon() {
  case "$1" in
    completed) echo "$e_done";;
    in-progress) echo "$e_hour";;
    blocked) echo "$e_block";;
    *) echo "$e_pending";;
  esac
}

obj_color() {
  case "$1" in
    completed) echo 32;;
    in-progress) echo 33;;
    blocked) echo 31;;
    *) echo 90;;
  esac
}

gate_icon() {
  case "$1" in
    passed) echo "$e_check";;
    blocked) echo "$e_block";;
    skipped) echo 'SK';;
    *) echo "$e_empty";;
  esac
}

gate_color() {
  case "$1" in
    passed) echo 32;;
    blocked) echo 31;;
    *) echo 90;;
  esac
}

render() {
  if [ ! -f "$STATE_FILE" ]; then
    echo "State file not found: $STATE_FILE"; exit 1
  fi

  clear
  local json; json=$(cat "$STATE_FILE")

  local project; project=$(echo "$json" | python3 -c "import sys,json; print(json.load(sys.stdin)['project'])" 2>/dev/null || echo "unknown")
  local updated; updated=$(echo "$json" | python3 -c "import sys,json; print(json.load(sys.stdin)['updatedAt'])" 2>/dev/null || echo "unknown")

  wl '+----------------------------------------------------+' 36
  wl '|    WORKFLOW STATE DASHBOARD    |' 37
  w "|  Project: " 37; wl "$project" 93
  w "|  Updated: " 90; wl "$updated" 90
  wl '+----------------------------------------------------+' 36
  wl ''
  wl '  Objectives:' 93

  local all_pending=true all_done=true
  local obj_count; obj_count=$(echo "$json" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for o in sorted(data['objectives'], key=lambda x: x['id']):
    status = o['status']
    print(f\"{o['id']}|{status}|{o.get('completedAt','')}|{o.get('completionPercentage','')}|{o['lead']}|{','.join(o['squad'])}|\")
  " 2>/dev/null || echo "")

  while IFS='|' read -r id status completed_at pct lead squad_str; do
    [ -z "$id" ] && continue
    local icon; icon=$(obj_icon "$status")
    local color; color=$(obj_color "$status")

    if [ "$status" = "completed" ]; then all_pending=false
    else all_done=false; fi
    [ "$status" != "pending" ] && all_pending=false

    w "  ${icon} " "$color"
    printf "%-22s" "$id"
    if [ "$status" = "completed" ] && [ -n "$completed_at" ]; then
      w "$completed_at" 90
    elif [ "$status" = "in-progress" ] && [ -n "$pct" ]; then
      local fill=$(( pct / 10 ))
      local bar; bar=$(printf '%*s' "$fill" '' | tr ' ' '#')$(printf '%*s' $((10-fill)) '' | tr ' ' '.')
      w "[${bar}] ${pct}%" 33
    fi
    wl ''
    w "     Lead: " 90; w "$lead" 37
    w "  Squad: " 90; wl "$squad_str" 90
  done <<< "$obj_count"

  wl ''
  wl '  Security Gates:' 93
  local gates; gates=$(echo "$json" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for k, v in data['phaseGates'].items():
    print(f'{k}|{v}')
  " 2>/dev/null || echo "")

  while IFS='|' read -r name val; do
    [ -z "$name" ] && continue
    local gicon; gicon=$(gate_icon "$val")
    local gcolor; gcolor=$(gate_color "$val")
    w "  ${gicon} " "$gcolor"
    printf "%-20s" "$name"
    wl "$val" 90
  done <<< "$gates"

  local log_dir="${SCRIPT_DIR}/../log"
  if [ -d "$log_dir" ]; then
    local logs; logs=$(find "$log_dir" -name '*.md' -type f 2>/dev/null | sort -r | head -5 || true)
    if [ -n "$logs" ]; then
      wl ''
      wl '  Recent Logs:' 93
      while IFS= read -r log; do
        local rel="${log#${SCRIPT_DIR}/../}"
        w "  ${e_doc} " 90; wl "$rel" 90
      done <<< "$logs"
    fi
  fi

  wl ''
  wl '+----------------------------------------------------+' 36
  if $all_done; then wl ''; wl '  ALL OBJECTIVES COMPLETE' 32; fi
  if $all_pending; then wl ''; wl '  No objectives started yet.' 90; fi
}

while true; do
  render
  [ "$WATCH" -le 0 ] && break
  sleep "$WATCH"
done
