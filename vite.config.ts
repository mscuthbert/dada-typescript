// vite.config.ts
import { defineConfig } from 'vite';
import { viteStaticCopy } from 'vite-plugin-static-copy';

export default defineConfig({
    base: './',
    plugins: [
        viteStaticCopy({
            targets: [
                {
                    src: 'scripts',
                    dest: '' // copied to dist/scripts/
                }
            ]
        })
    ]
});
