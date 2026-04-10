async function getSettings(name) {
    try {
        const response = await fetch(`http://localhost:2007/get_handle?name=${name}`);
        if (!response.ok) throw new Error(`Ошибка сети: ${response.status}`);

        const { data } = await response.json();
        if (!data?.sections) {
            console.warn("Структура данных не соответствует ожидаемой");
            return null;
        }

        return transformJSON(data);
    } catch (error) {
        console.error(error);
        return null;
    }
}

function transformJSON(data) {
    const result = {};

    try {
        data.sections.forEach(section => {
            section.items.forEach(item => {
                if (item.type === "text" && item.buttons) {
                    result[item.id] = {};
                    item.buttons.forEach(button => {
                        result[item.id][button.id] = {
                            value: button.text,
                            default: button.defaultParameter
                        };
                    });
                } else {
                    result[item.id] = {
                        value: item.bool || item.input || item.selected || item.value || item.filePath,
                        default: item.defaultParameter
                    };
                }
            });
        });
    } finally {
        return result;
    }
}

function applySettings(settings) {
    let themeStyleElement = document.getElementById('mai-theme-style');
    if (!themeStyleElement) {
        themeStyleElement = document.createElement('style');
        themeStyleElement.id = 'mai-theme-style';
        document.head.appendChild(themeStyleElement);
    }

    themeStyleElement.textContent = '';

    if (settings.mainColor && settings.mainColor.value) {
        const color = settings.mainColor.value;
        themeStyleElement.textContent += `
            :root {
                --ym-controls-color-primary-default-enabled: ${color} !important;
            }
        `;
    }

    if (settings.disableVibe && settings.disableVibe.value === true) {
        themeStyleElement.textContent += `
            [class*="VibeAnimation_root"] {
                display: none !important;
            }
        `;
    }

    if (settings.disableVibeGif && settings.disableVibeGif.value === true) {
        themeStyleElement.textContent += `
            .VibeBlock_root__z7LtR {
                background-image: none !important;
            }
            [class*="VibeBlock_root"]:not([class*="VibeBlock_root_freemium"]) {
                background-image: none !important;
            }
        `;
    }
}

setInterval(async () => {
    const settings = await getSettings("Rascal Does Not Dream");
    if (!settings) return;

    applySettings(settings);
}, 2000);
