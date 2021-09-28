module.exports = {
  mode: 'jit',
  purge: [
    './app/views/**/*.html.erb',
    './app/javascript/**/*.js',
    // './src/**/*.{js,jsx,ts,tsx,vue}',  useful syntax for multiple file types
  ],
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
}
