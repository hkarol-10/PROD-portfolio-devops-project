// =============================
// FUNKCJE
// =============================

// Zmiana trybu dark/light
// Zmiana trybu dark/light
function changeTheme() {
  const modeSwitch = document.getElementById("modeSwitch");
  if (!modeSwitch) return;

  const isLight = modeSwitch.checked;

  // ustawienie kolorów globalnych
  document.body.style.backgroundColor = isLight ? "#ffffff" : "#121212";
  document.body.style.color = isLight ? "#000000" : "#ffffff";

  // nadpisanie wszystkich page-subtitle
  document.querySelectorAll(".page-subtitle").forEach(el => {
    el.style.color = isLight ? "#000000" : "#ffffff";
  });

  localStorage.setItem("theme", isLight ? "light" : "dark");
}


// Tłumaczenia zostaną wczytane dynamicznie
let translations = {};

// Funkcja zmiany języka
function handleLanguageSwitch() {
  const langSwitch = document.getElementById("langSwitch");
  if (!langSwitch) return;

  const lang = langSwitch.checked ? "pl" : "en";
  localStorage.setItem("lang", lang);

  if (!translations[lang]) return;

  // Iterujemy po tłumaczeniach i zmieniamy tylko te elementy, które istnieją
  for (const [id, text] of Object.entries(translations[lang])) {
    const element = document.getElementById(id);
    if (element) {
      element.innerText = text;
    }
  }
}

// =============================
// Wczytywanie header i footer
// =============================
function loadHeaderFooter() {
  // Header
  fetch("header.html")
    .then(resp => resp.text())
    .then(data => {
      const headerContainer = document.getElementById("header");
      if (headerContainer) {
        headerContainer.innerHTML = data;

        const modeSwitch = document.getElementById("modeSwitch");
        const langSwitch = document.getElementById("langSwitch");

        if (modeSwitch) {
          // ustawienie stanu zgodnie z localStorage
          const savedTheme = localStorage.getItem("theme");
          modeSwitch.checked = savedTheme === "light";
          changeTheme();

          modeSwitch.addEventListener("change", changeTheme);
        }

        if (langSwitch) {
          // ustawienie stanu zgodnie z localStorage
          const savedLang = localStorage.getItem("lang");
          langSwitch.checked = savedLang === "pl";
          handleLanguageSwitch();

          langSwitch.addEventListener("change", handleLanguageSwitch);
        }
      }
    })
    .catch(err => console.error("Nie udało się wczytać headera:", err));

  // Footer
  fetch("footer.html")
    .then(resp => resp.text())
    .then(data => {
      const footerContainer = document.getElementById("footer");
      if (footerContainer) {
        footerContainer.innerHTML = data;
      }
    })
    .catch(err => console.error("Nie udało się wczytać footera:", err));
}

// =============================
// Wczytywanie translations.json
// =============================
function loadTranslations() {
  fetch("js/translations.json")
    .then(resp => resp.json())
    .then(data => {
      translations = data;
      handleLanguageSwitch(); // ustaw tłumaczenia po wczytaniu JSON
    })
    .catch(err => console.error("Nie udało się wczytać translations.json:", err));
}

// =============================
// Inicjalizacja strony
// =============================
document.addEventListener("DOMContentLoaded", () => {
  loadHeaderFooter();
  loadTranslations();
});
