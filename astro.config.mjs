import { defineConfig } from 'astro/config';

export default defineConfig({
  srcDir: "./src",
  publicDir: "./public",
  outDir: "./dist",
  server: {
    port: 3000
  },
  vite: {
    renderBuiltUrl(filename, { type }) {
      if (type === 'asset') {
        return filename;
      }
      return undefined;
    }
  }
});
