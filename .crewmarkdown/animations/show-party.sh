#!/usr/bin/env bash
# Retro RPG Party Screen — gamified squad status display for CrewMarkdown
# Shows an animated terminal party screen when AI squads assemble.
# Usage: ./show-party.sh --objective "Design Solution" --squad "PM,Architect,Backend,Security"
#        ./show-party.sh -o "Build Feature" -s "Frontend,Backend,QA" -t 5
#        ./show-party.sh -o "Verify Quality" -s "QA,Security,DevOps" --ascii

set -euo pipefail

# ─── Defaults ────────────────────────────────────────────────────────────

OBJECTIVE="Unknown Objective"
SQUAD_STR="Orchestrator"
TIMEOUT=0
NO_ANIM=false
ASCII=false

# ─── Parse args ──────────────────────────────────────────────────────────

while [[ $# -gt 0 ]]; do
  case "$1" in
    -o|--objective) OBJECTIVE="$2"; shift 2 ;;
    -s|--squad) SQUAD_STR="$2"; shift 2 ;;
    -t|--timeout) TIMEOUT="$2"; shift 2 ;;
    -n|--no-anim) NO_ANIM=true; shift ;;
    -a|--ascii) ASCII=true; shift ;;
    *) echo "Usage: $0 -o OBJECTIVE -s SQUAD [-t TIMEOUT] [-n] [-a]"; exit 1 ;;
  esac
done

IFS=',' read -ra SQUAD <<< "$SQUAD_STR"

# ─── Terminal helpers ────────────────────────────────────────────────────

ESC=$'\033'

set_cursor() { printf "${ESC}[%d;%dH" "$2" "$1"; }
hide_cursor() { printf "${ESC}[?25l"; }
show_cursor() { printf "${ESC}[?25h"; }

set_fg() {
  local c
  case "$1" in
    red)   c=31;; green) c=32;; yellow) c=33;;
    blue)  c=34;; magenta) c=35;; cyan) c=36;;
    white) c=37;; gray) c=90;; dim) c=2;;
    *)     c=37;;
  esac
  printf "${ESC}[${c}m"
}

set_bg() {
  local c
  case "$1" in
    red) c=41;; green) c=42;; yellow) c=43;;
    blue) c=44;; magenta) c=45;; cyan) c=46;;
    gray) c=100;;
    *)   c=40;;
  esac
  printf "${ESC}[${c}m"
}

reset_color() { printf "${ESC}[0m"; }

# ─── Icons ───────────────────────────────────────────────────────────────

if $ASCII; then
  icon_PM='[PM]'; icon_BA='[BA]'; icon_Arch='[AR]'; icon_TL='[TL]'
  icon_FE='[FE]'; icon_BE='[BE]'; icon_MB='[MB]'; icon_UX='[UX]'
  icon_DE='[DE]'; icon_ML='[ML]'; icon_QA='[QA]'; icon_Sec='[SE]'
  icon_DO='[DO]'; icon_EM='[EM]'; icon_DB='[DB]'; icon_MF='[MF]'; icon_Orch='[OR]'
  icon_UNK='[?]'
else
  icon_PM='📋'; icon_BA='📊'; icon_Arch='🏗️'; icon_TL='👨‍💻'; icon_FE='🎨'
  icon_BE='⚙️'; icon_MB='📱'; icon_UX='✏️'; icon_DE='🗄️'; icon_ML='🧠'
  icon_QA='🔍'; icon_Sec='🛡️';   icon_DO='🚀'; icon_EM='📅'; icon_DB='⚖️'; icon_MF='🎤'; icon_Orch='🎯'
  icon_UNK='?'
fi

get_icon() {
  case "$1" in
    PM|pm|Pm)           echo "$icon_PM";;
    BA|ba|Ba)           echo "$icon_BA";;
    Architect|architect) echo "$icon_Arch";;
    Tech*|tech*)        echo "$icon_TL";;
    Frontend|frontend)  echo "$icon_FE";;
    Backend|backend)    echo "$icon_BE";;
    Mobile|mobile)      echo "$icon_MB";;
    UX|ux)              echo "$icon_UX";;
    Data|data)          echo "$icon_DE";;
    ML|ml)              echo "$icon_ML";;
    QA|qa|Qa)           echo "$icon_QA";;
    Security|security)  echo "$icon_Sec";;
    DevOps|devops)      echo "$icon_DO";;
    EM|em|Em)           echo "$icon_EM";;
    Debator|debator|Facilitator) echo "$icon_DB";;
    Meeting*|meeting*) echo "$icon_MF";;
    Orchestrator|orchestrator) echo "$icon_Orch";;
    *)                  echo "$icon_UNK";;
  esac
}

# ─── Actions per role ────────────────────────────────────────────────────

declare -A ROLE_ACTIONS
ROLE_ACTIONS[PM]="Gathering requirements,Writing PRD,Prioritizing backlog,Aligning stakeholders,Defining scope"
ROLE_ACTIONS[BA]="Analyzing requirements,Writing user stories,Gap analysis,Mapping dependencies,Documenting flows"
ROLE_ACTIONS[Architect]="Designing architecture,Evaluating tech stack,Creating diagrams,Writing ADRs,Defining patterns"
ROLE_ACTIONS[Tech Lead]="Reviewing designs,Setting standards,Planning sprints,Code review,Technical guidance"
ROLE_ACTIONS[Frontend]="Building UI components,Styling layouts,Client logic,Integration,State management"
ROLE_ACTIONS[Backend]="Implementing API,Designing DB schema,Writing services,Business logic,Data modeling"
ROLE_ACTIONS[Mobile]="Building mobile UI,Offline support,Push notifications,App store prep,API integration"
ROLE_ACTIONS[UX]="Creating wireframes,User research,Prototyping,Usability testing,Design system"
ROLE_ACTIONS[Data]="Building pipelines,Designing schemas,Data quality,ETL/ELT,Data catalog"
ROLE_ACTIONS[ML]="Training models,Feature engineering,Model evaluation,Serving endpoints,Drift monitoring"
ROLE_ACTIONS[QA]="Planning tests,Writing test cases,Running tests,Regression,Bug tracking"
ROLE_ACTIONS[Security]="Threat modeling,Security review,Pentesting,SBOM,Security gates"
ROLE_ACTIONS[DevOps]="Setting up CI/CD,Infrastructure,Deployment,Monitoring,Release mgmt"
ROLE_ACTIONS[EM]="Sprint planning,Capacity allocation,Retrospective,Velocity tracking,Standups"
ROLE_ACTIONS[Debator]="Moderating debate,Structuring arguments,Scoring options,Documenting decisions,Timeboxing"
ROLE_ACTIONS[Meeting Facilitator]="Setting agenda,Leading brainstorm,Capturing decisions,Assigning action items,Writing minutes"
ROLE_ACTIONS[Orchestrator]="Decomposing request,Assigning squads,Tracking progress,Cross-obj coordination,Status reporting"

get_actions() {
  local actions="${ROLE_ACTIONS[$1]:-Working...}"
  echo "$actions"
}

# ─── Objective actions ───────────────────────────────────────────────────

declare -A OBJ_ACTIONS
OBJ_ACTIONS[Clarify Vision]="Clarifying scope,Defining success,Aligning stakeholders,Setting priorities"
OBJ_ACTIONS[Design Solution]="Architecture design,Component modeling,Interface definition,Pattern selection"
OBJ_ACTIONS[Plan Work]="Sprint planning,Task breakdown,Capacity analysis,Dependency mapping"
OBJ_ACTIONS[Build Feature]="Feature implementation,Component building,Integration testing,Code review"
OBJ_ACTIONS[Verify Quality]="Test execution,Quality gate review,Security scanning,Performance validation"
OBJ_ACTIONS[Ship Release]="Release preparation,Deployment pipeline,Environment config,Rollback planning"
OBJ_ACTIONS[Operate & Learn]="Monitoring review,Feedback analysis,Incident response,Improvement planning"
OBJ_ACTIONS[Conduct Meeting]="Setting the agenda,Brainstorming ideas,Making decisions,Capturing action items,Writing minutes"

get_obj_action() {
  local actions="${OBJ_ACTIONS[$1]:-Processing,Analyzing,Building,Reviewing}"
  local arr=(${actions//,/ })
  echo "${arr[$((RANDOM % ${#arr[@]}))]}"
}

# ─── Progress bar ────────────────────────────────────────────────────────

draw_bar() {
  local pct=$1 width=${2:-12}
  local fill=$(( pct * width / 100 ))
  local empty=$(( width - fill ))
  [ $fill -gt $width ] && fill=$width
  [ $fill -lt 0 ] && fill=0
  [ $empty -lt 0 ] && empty=0

  printf '['
  if [ $pct -ge 100 ]; then set_fg green
  elif [ $pct -ge 50 ]; then set_fg yellow
  else set_fg gray
  fi
  printf '%*s' "$fill" '' | tr ' ' '█'
  reset_color
  printf '%*s' "$empty" '' | tr ' ' '░'
  printf ']'
}

# ─── Main display ────────────────────────────────────────────────────────

CONTENT_WIDTH=60

show_party() {
  local start_time elapsed pct_str action_text
  local -a role_names role_icons role_pcts role_act_idxs role_action_arr
  local role_count=${#SQUAD[@]}

  # Build squad arrays
  for ((i=0; i<role_count; i++)); do
    local r="${SQUAD[$i]}"
    role_names[$i]="$r"
    role_icons[$i]=$(get_icon "$r")
    if $NO_ANIM; then
      role_pcts[$i]=0
    else
      role_pcts[$i]=$(( RANDOM % 30 + 5 ))
    fi
    role_act_idxs[$i]=$(( RANDOM % 5 ))
    role_action_arr[$i]=$(get_actions "$r")
  done

  # Role name padding
  local max_role_len=8
  for r in "${role_names[@]}"; do
    [ ${#r} -gt $max_role_len ] && max_role_len=${#r}
  done
  [ $max_role_len -gt 14 ] && max_role_len=14

  hide_cursor
  start_time=$SECONDS

  draw_frame() {
    local y=1 elapsed=$1
    local h=$(( elapsed / 3600 ))
    local m=$(( (elapsed % 3600) / 60 ))
    local s=$(( elapsed % 60 ))
    local elapsed_fmt=$(printf "⏱  %02d:%02d:%02d" $h $m $s)

    # Top
    set_cursor 1 $y
    set_fg cyan; printf '╔'; printf '═%.0s' $(seq 1 $((CONTENT_WIDTH+2))); printf '╗'; reset_color
    ((y++))

    # Title
    set_cursor 1 $y
    if $ASCII; then local title=" AGENT CREW ASSEMBLED "
    else local title=" 🎯 AGENT CREW ASSEMBLED "; fi
    local pad=$(( (CONTENT_WIDTH - ${#title}) / 2 ))
    [ $pad -lt 0 ] && pad=0
    local rpad=$(( CONTENT_WIDTH - pad - ${#title} ))
    [ $rpad -lt 0 ] && rpad=0
    set_fg white; set_bg blue; printf '║%*s%s%*s║' $pad '' "$title" $rpad ''; reset_color
    ((y++))

    # Objective
    set_cursor 1 $y
    set_fg white
    printf '║   %s' "$OBJECTIVE"
    local objpad=$(( CONTENT_WIDTH - 3 - ${#OBJECTIVE} + 1 ))
    [ $objpad -lt 0 ] && objpad=0
    printf '%*s' $objpad ''
    reset_color
    printf '║'
    ((y++))

    # Separator
    set_cursor 1 $y
    set_fg cyan; printf '╠'; printf '═%.0s' $(seq 1 $((CONTENT_WIDTH+2))); printf '╣'; reset_color
    ((y++)); ((y++))

    # Squad rows
    for ((i=0; i<role_count; i++)); do
      set_cursor 1 $y
      set_fg white; printf '║  %s ' "${role_icons[$i]}"
      set_fg yellow
      printf "%-*s" "$max_role_len" "${role_names[$i]}"
      reset_color
      printf '  '
      draw_bar "${role_pcts[$i]}"
      set_fg gray
      printf ' %3d%%' "${role_pcts[$i]}"
      reset_color
      printf '  '
      set_fg dim
      local action_line
      IFS=',' read -ra acts <<< "${role_action_arr[$i]}"
      action_text="${acts[${role_act_idxs[$i]}]:-Working...}"
      [ ${#action_text} -gt 24 ] && action_text="${action_text:0:21}..."
      printf "%-24s" "$action_text"
      reset_color
      set_cursor $((CONTENT_WIDTH+4)) $y
      printf '║'
      ((y++))
    done

    ((y++))

    # Separator
    set_cursor 1 $y
    set_fg cyan; printf '╠'; printf '═%.0s' $(seq 1 $((CONTENT_WIDTH+2))); printf '╣'; reset_color
    ((y++))

    # Footer
    set_cursor 1 $y
    set_fg gray
    printf '║ %s' "$elapsed_fmt"
    reset_color
    local phase_action=$(get_obj_action "$OBJECTIVE")
    local footer_right="  $phase_action  "
    local footer_mid=$(( CONTENT_WIDTH - ${#elapsed_fmt} - 2 - ${#footer_right} ))
    [ $footer_mid -lt 1 ] && footer_mid=1
    printf '%*s' $footer_mid ''
    set_fg gray
    printf '%s║' "$footer_right"
    reset_color
    ((y++))

    # Bottom
    set_cursor 1 $y
    set_fg cyan; printf '╚'; printf '═%.0s' $(seq 1 $((CONTENT_WIDTH+2))); printf '╝'; reset_color
  }

  update_squad() {
    for ((i=0; i<role_count; i++)); do
      local inc=$(( RANDOM % 4 ))
      local new_pct=$(( ${role_pcts[$i]} + inc ))
      [ $new_pct -gt 100 ] && new_pct=100
      role_pcts[$i]=$new_pct
      if [ $(( RANDOM % 3 )) -eq 0 ]; then
        IFS=',' read -ra acts <<< "${role_action_arr[$i]}"
        role_act_idxs[$i]=$(( RANDOM % ${#acts[@]} ))
      fi
    done
  }

  # Trap to ensure cursor is shown on exit
  cleanup() { show_cursor; reset_color; printf '\n'; }
  trap cleanup EXIT INT TERM

  if $NO_ANIM; then
    draw_frame 0
    printf '\n\n  [Static display — use --no-anim or -n for animation]\n'
    sleep 2
    return
  fi

  while true; do
    local elapsed=$(( SECONDS - start_time ))
    if [ "$TIMEOUT" -gt 0 ] && [ "$elapsed" -ge "$TIMEOUT" ]; then
      # Final: all 100%
      for ((i=0; i<role_count; i++)); do
        role_pcts[$i]=100
        role_act_idxs[$i]=0
      done
      draw_frame "$elapsed"
      sleep 1
      break
    fi
    draw_frame "$elapsed"
    sleep 0.6
    update_squad
  done
}

show_party
