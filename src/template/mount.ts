import { getAddonSettings, readBooleanSetting } from '@/pulsesync'

import { ensureThemeStyle, ensureCustomTitlebar } from './dom'

type ThemeSettings = {
    disableVibe: boolean
    disableVibeGif: boolean
}

function applyThemeSettings(settings: ThemeSettings): void {
    const themeStyleElement = ensureThemeStyle()
    themeStyleElement.textContent = ''

    if (settings.disableVibe) {
        themeStyleElement.textContent += `
            [class*="VibeAnimation_root"] {
                display: none !important;
            }
        `
    } else {
        themeStyleElement.textContent += `
            [class*="VibeAnimation_root"] {
                display: block !important;
            }
        `
    }

    if (settings.disableVibeGif) {
        themeStyleElement.textContent += `
            .VibeBlock_root__z7LtR {
                background-image: none !important;
            }
            [class*="VibeBlock_root"]:not([class*="VibeBlock_root_freemium"]) {
                background-image: none !important;
            }
        `
    }
}

function initCustomTitlebar(): void {
    const titlebarText = ensureCustomTitlebar()
    if (!titlebarText) return

    const checkTitleBar = setInterval(() => {
        const titleBar = document.querySelector('[class*="TitleBar_root"]')
        if (titleBar) {
            titleBar.appendChild(titlebarText)
            clearInterval(checkTitleBar)
        }
    }, 100)

    setTimeout(() => clearInterval(checkTitleBar), 10000)
}

export function mountTheme(): void {
    const settingsStore = getAddonSettings('Rascal Does Not Dream')
    let settings = settingsStore.getCurrent()

    const update = () => {
        applyThemeSettings({
            disableVibe: readBooleanSetting(settings, 'disableVibe', true),
            disableVibeGif: readBooleanSetting(settings, 'disableVibeGif', false),
        })
    }

    initCustomTitlebar()
    update()

    settingsStore.onChange(nextSettings => {
        settings = nextSettings
        update()
    })
}