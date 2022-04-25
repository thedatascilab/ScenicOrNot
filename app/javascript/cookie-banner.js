import Cookies from "js-cookie";

const hasConsent = Cookies.get("hasConsent");
const hasRejected = Cookies.get("hasRejected");

if (!hasRejected) {
  const hideBanner = () => {
    document.getElementById("cookieBanner").classList.add("hidden");
  };

  const showBanner = () => {
    document.getElementById("cookieBanner").classList.remove("hidden");
  };

  const acceptCookies = () => {
    Cookies.set("hasConsent", true, { expires: 365 });
  };

  const rejectCookies = () => {
    Cookies.set("hasRejected", true, { expires: 365 });
  };

  const enableScript = (script) => {
    const newScript = document.createElement("script");
    newScript.text = script.text;
    const parent = script.parentElement;
    newScript.setAttribute("type", "text/javascript");
    const src = script.getAttribute("src");
    if (src) {
      newScript.setAttribute("src", src);
    }
    parent.insertBefore(newScript, script);
    parent.removeChild(script);
  };

  if (!hasConsent) {
    showBanner();

    const acceptButton = document.getElementById("acceptCookies");
    const rejectButton = document.getElementById("rejectCookies");

    acceptButton.addEventListener("click", () => {
      acceptCookies();
      hideBanner();
    });

    rejectButton.addEventListener("click", () => {
      rejectCookies();
      hideBanner();
    });
  } else {
    const scripts = document.querySelectorAll("[data-cookies]");

    for (let i = 0; i < scripts.length; i++) {
      enableScript(scripts[i]);
    }
  }
}
