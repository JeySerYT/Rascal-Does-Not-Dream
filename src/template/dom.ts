import { THEME_STYLE_ID, CUSTOM_TITLEBAR_ID } from './constants'

export function ensureThemeStyle(): HTMLStyleElement {
    const existing = document.getElementById(THEME_STYLE_ID)
    if (existing instanceof HTMLStyleElement) {
        return existing
    }

    const style = document.createElement('style')
    style.id = THEME_STYLE_ID
    document.head.appendChild(style)
    return style
}

export function ensureCustomTitlebar(): HTMLDivElement | null {
    if (!document.body) {
        return null
    }

    const existing = document.getElementById(CUSTOM_TITLEBAR_ID)
    if (existing instanceof HTMLDivElement) {
        return existing
    }

    const titlebar = document.createElement('div')
    titlebar.id = CUSTOM_TITLEBAR_ID
    titlebar.className = 'mai-custom-titlebar'
    titlebar.textContent = 'Rascal Does Not Dream'
    document.body.appendChild(titlebar)
    return titlebar
}