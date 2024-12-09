import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

// https://vite.dev/config/
export default defineConfig({
  resolve: {
    alias: {
      '~bootstrap': path.resolve(__dirname, 'node_modules/bootstrap'),
    }
  },
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
