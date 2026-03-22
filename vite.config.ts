import { defineConfig } from 'vite-plus';

export default defineConfig({
  lint: {
    ignorePatterns: ['dist/**'],
    options: { typeAware: true, typeCheck: true },
    rules: {
      correctness: 'error',
      suspicious: 'error',
      perf: 'warn',
    },
  },
  fmt: {
    singleQuote: true,
    semi: true,
    tabWidth: 2,
    printWidth: 100,
    trailingComma: 'all',
  },
});
