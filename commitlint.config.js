export default {
  extends: ['@commitlint/config-conventional'],
  plugins: [
    {
      rules: {
        'english-only': (parsed) => {
          const { header } = parsed;

          // Detect non-ASCII characters (Japanese, Chinese, etc.)
          const nonEnglishRegex = /[^\x00-\x7F]/;

          if (header && nonEnglishRegex.test(header)) {
            return [
              false,
              'Commit message must be in English only. Non-ASCII characters detected.',
            ];
          }

          return [true, ''];
        },
      },
    },
  ],
  rules: {
    'english-only': [2, 'always'],
  },
};
