import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  preview: {
    port: 8506,
    strictPort: true,
    host: true,
  },
  server: {
    port: 8506,
    strictPort: true,
    host: true,
    origin: "http://0.0.0.0:8506"
  },
  plugins: [react()],
})
