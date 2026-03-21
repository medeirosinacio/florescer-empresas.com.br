document.addEventListener("DOMContentLoaded", function () {
    const els = document.querySelectorAll("[data-animate]");
    if (!els.length) return;

    const observer = new IntersectionObserver(
        (entries) => {
            entries.forEach((entry) => {
                if (entry.isIntersecting) {
                    entry.target.classList.add("visible");
                    observer.unobserve(entry.target);
                }
            });
        },
        { threshold: 0.1 }
    );

    els.forEach((el) => observer.observe(el));
});
