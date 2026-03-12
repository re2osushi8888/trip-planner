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
  prompt: {
    settings: {
      enableMultipleScopes: true,
      scopeEnumSeparator: ',',
    },
    messages: {
      skip: ':skip',
      max: 'upper %d chars',
      min: '%d chars at least',
      emptyWarning: 'can not be empty',
      upperLimitWarning: 'over limit',
      lowerLimitWarning: 'below limit',
    },
    questions: {
      type: {
        description: "Select the type of change that you're committing:",
      },
      scope: {
        description: 'What is the scope of this change (e.g. component or file name):',
      },
      subject: {
        description: 'Write a short, imperative tense description of the change (in English):',
      },
      body: {
        description: 'Provide a longer description of the change (optional, in English):',
      },
      isBreaking: {
        description: 'Are there any breaking changes?',
      },
      breaking: {
        description: 'Describe the breaking changes:',
      },
      isIssueAffected: {
        description: 'Does this change affect any open issues?',
      },
      issues: {
        description: 'Add issue references (e.g. "fix #123", "re #456"):',
      },
    },
  },
};
