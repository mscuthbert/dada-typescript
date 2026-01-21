// vite.config.ts
import { defineConfig } from 'vite';
import { viteStaticCopy } from 'vite-plugin-static-copy';

export default defineConfig({
    base: './',
    server: {
        watch: {
            ignored: ['!**/*.pb'],  // hot-reload .pb
        },
    },
    plugins: [
        viteStaticCopy({
            targets: [
                {
                    src: 'scripts',
                    dest: '' // copied to dist/scripts/
                }
            ]
        }),
        {
            name: 'watch-pb-files',
            handleHotUpdate({ file, server }) {
                if (file.endsWith('.pb')) {
                    server.ws.send({ type: 'full-reload' });
                }
            },
        },
    ],
});
