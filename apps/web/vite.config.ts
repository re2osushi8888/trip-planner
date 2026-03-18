import { defineConfig } from 'vite-plus';
import react from '@vitejs/plugin-react';

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: true, // Enable access from Windows host
    port: 5173,
  },
});
