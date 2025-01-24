const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.erb',
    './node_modules/flowbite/**/*.js',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      fontSize: {
        'xxs': '0.33rem',
      },
    },
  },
  plugins: [
    function ({ addVariant }) {
      addVariant('hotwire-native', ({ modifySelectors, separator }) => {
        modifySelectors(({ className }) => {
          return `body[data-hotwire-native] &`;
        });
      });

      addVariant('not-hotwire-native', ({ modifySelectors, separator }) => {
        modifySelectors(({ className }) => {
          return `body:not([data-hotwire-native]) &`;
        });
      });
    },
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('flowbite/plugin')
  ]
}
