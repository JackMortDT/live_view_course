module.exports = {
  mode: "jit",
  theme: {
    extend: {
      colors: {
        "cool-gray": {
          50: "#f8fafc",
          100: "#f1f5f9",
          200: "#e2e8f0",
          300: "#cfd8e3",
          400: "#97a6ba",
          500: "#64748b",
          600: "#475569",
          700: "#364152",
          800: "#27303f",
          900: "#1a202e"
        }
      }
    }
  },
  variants: {
    extend: {}
  },
  plugins: [],
  purge: ["../lib/*_web/**/*.*ex", "./js/**/*.js"]
}
