// ── CrewMarkdown Docs — Interactivity ──

document.addEventListener('DOMContentLoaded', () => {

  // Mobile sidebar toggle
  const toggle = document.getElementById('menuToggle')
  const sidebar = document.querySelector('.sidebar')
  const overlay = document.getElementById('sidebarOverlay')

  if (toggle && sidebar && overlay) {
    const open = () => {
      sidebar.classList.add('open')
      overlay.classList.add('active')
      document.body.style.overflow = 'hidden'
    }
    const close = () => {
      sidebar.classList.remove('open')
      overlay.classList.remove('active')
      document.body.style.overflow = ''
    }
    toggle.addEventListener('click', open)
    overlay.addEventListener('click', close)

    // Close on escape
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && sidebar.classList.contains('open')) close()
    })
  }

  // Active nav highlight
  const page = document.body.dataset.page
  if (page) {
    document.querySelectorAll('.nav-list a').forEach(a => {
      const href = a.getAttribute('href')
      if (href === page || href === page + '.html') {
        a.closest('li').classList.add('active')
      }
    })
  }

  // Smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', (e) => {
      const target = document.querySelector(a.getAttribute('href'))
      if (target) {
        e.preventDefault()
        target.scrollIntoView({ behavior: 'smooth' })
      }
    })
  })

  // Animate role cards on scroll
  const cards = document.querySelectorAll('.role-card, .feature-card, .gate-card')
  if ('IntersectionObserver' in window) {
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.style.opacity = '1'
            entry.target.style.transform = 'translateY(0)'
          }
        })
      },
      { threshold: 0.1 }
    )
    cards.forEach(card => {
      card.style.opacity = '0'
      card.style.transform = 'translateY(20px)'
      card.style.transition = 'opacity 0.5s ease, transform 0.5s ease'
      observer.observe(card)
    })
  }
})
