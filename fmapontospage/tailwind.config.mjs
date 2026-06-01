/** @type {import('tailwindcss').Config} */
export default {
    content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
    darkMode: 'selector',
    theme: {
        extend: {
            colors: {
                cream: {
                    DEFAULT: '#FDFCF8',
                    muted: '#F5F3EE',
                },
                gold: {
                    DEFAULT: '#C5A04D',
                    dark: '#A8883E',
                    light: '#D4B96A',
                },
                fma: {
                    text: '#1C1B1B',
                    muted: '#57534E',
                    green: '#1DB954',
                },
            },
            fontFamily: {
                sans: ['"Plus Jakarta Sans"', 'Inter', 'system-ui', 'sans-serif'],
                serif: ['"Playfair Display"', 'Georgia', 'serif'],
            },
            borderRadius: {
                button: '12px',
                card: '16px',
            },
            boxShadow: {
                gold: '0 4px 20px rgba(197, 160, 77, 0.2)',
                'gold-lg': '0 10px 40px rgba(197, 160, 77, 0.35)',
            },
        },
    },
    plugins: [],
};
