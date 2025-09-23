// =============================
// Zmiana trybu dark/light
// =============================
function changeTheme() {
  const modeSwitch = document.getElementById("modeSwitch");
  if (!modeSwitch) return;

  const isLight = modeSwitch.checked;
  document.body.style.backgroundColor = isLight ? "#ffffff" : "#121212";
  document.body.style.color = isLight ? "#000000" : "#ffffff";

  document.querySelectorAll(".page-subtitle").forEach(el => {
    el.style.color = isLight ? "#000000" : "#ffffff";
  });

  localStorage.setItem("theme", isLight ? "light" : "dark");
}

// =============================
// Zmiana języka
// =============================
let translations = {};

function handleLanguageSwitch() {
  const langSwitch = document.getElementById("langSwitch");
  if (!langSwitch) return;

  const lang = langSwitch.checked ? "pl" : "en";
  localStorage.setItem("lang", lang);

  if (!translations[lang]) return;

  for (const [id, text] of Object.entries(translations[lang])) {
    const element = document.getElementById(id);
    if (element) element.innerText = text;
  }
}

// =============================
// Wczytywanie header i footer
// =============================
function loadHeaderFooter() {
  fetch("header.html").then(r => r.text()).then(data => {
    const headerContainer = document.getElementById("header");
    if (headerContainer) {
      headerContainer.innerHTML = data;
      const modeSwitch = document.getElementById("modeSwitch");
      const langSwitch = document.getElementById("langSwitch");

      if (modeSwitch) {
        const savedTheme = localStorage.getItem("theme");
        modeSwitch.checked = savedTheme === "light";
        changeTheme();
        modeSwitch.addEventListener("change", changeTheme);
      }

      if (langSwitch) {
        const savedLang = localStorage.getItem("lang");
        langSwitch.checked = savedLang === "pl";
        handleLanguageSwitch();
        langSwitch.addEventListener("change", handleLanguageSwitch);
      }
    }
  }).catch(err => console.error("Header load error:", err));

  fetch("footer.html").then(r => r.text()).then(data => {
    const footerContainer = document.getElementById("footer");
    if (footerContainer) footerContainer.innerHTML = data;
  }).catch(err => console.error("Footer load error:", err));
}

// =============================
// Wczytywanie translations.json
// =============================
function loadTranslations() {
  fetch("js/translations.json").then(r => r.json()).then(data => {
    translations = data;
    handleLanguageSwitch();
  }).catch(err => console.error("Translations load error:", err));
}

// =============================
// Carousel functionality
// =============================
function initCarousels() {
  document.querySelectorAll('.carousel-wrapper').forEach(wrapper => {
    const carousel = wrapper.querySelector('.carousel');
    const prevBtn = wrapper.querySelector('.prev');
    const nextBtn = wrapper.querySelector('.next');

    const scrollAmount = 200;

    prevBtn.addEventListener('click', () => {
      carousel.scrollBy({ left: -scrollAmount, behavior: 'smooth' });
    });

    nextBtn.addEventListener('click', () => {
      carousel.scrollBy({ left: scrollAmount, behavior: 'smooth' });
    });
  });
}

// =============================
// Inicjalizacja strony
// =============================
document.addEventListener("DOMContentLoaded", () => {
  loadHeaderFooter();
  loadTranslations();
  initCarousels();
});