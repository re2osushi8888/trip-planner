export default {
  extends: ["@commitlint/config-conventional"],
  plugins: [
    {
      rules: {
        "english-only": (parsed) => {
          const { header } = parsed;

          // Detect non-ASCII characters (Japanese, Chinese, etc.)
          const nonEnglishRegex = /[^\x00-\x7F]/;

          if (header && nonEnglishRegex.test(header)) {
            return [
              false,
              "Commit message must be in English only. Non-ASCII characters detected.",
            ];
          }

          return [true, ""];
        },
      },
    },
  ],
  rules: {
    "english-only": [2, "always"],
    "scope-enum": [
      2,
      "always",
      [
        // Application layers
        "api",
        "web",
        "mobile",
        // Features
        "auth",
        "trip",
        "booking",
        "search",
        "user",
        "notification",
        "payment",
        // Technical & Tools
        "deps",
        "config",
        "ci",
        "docker",
        "test",
        "scripts",
        "lint",
        // Documentation
        "docs",
        "readme",
        "claude",
        // Database & Infrastructure
        "db",
        "cache",
        "queue",
        // Monorepo packages (if applicable)
        "shared",
        "utils",
      ],
    ],
    "scope-case": [2, "always", "kebab-case"],
  },
  prompt: {
    settings: {
      enableMultipleScopes: true,
      scopeEnumSeparator: ",",
    },
    messages: {
      skip: ":skip",
      max: "upper %d chars",
      min: "%d chars at least",
      emptyWarning: "can not be empty",
      upperLimitWarning: "over limit",
      lowerLimitWarning: "below limit",
    },
    questions: {
      type: {
        description: "Select the type of change that you're committing:",
      },
      scope: {
        description: "What is the scope of this change (e.g. component or file name):",
        enum: {
          api: {
            description: "API related changes",
            title: "API",
          },
          web: {
            description: "Web frontend changes",
            title: "Web",
          },
          mobile: {
            description: "Mobile app changes",
            title: "Mobile",
          },
          auth: {
            description: "Authentication and authorization",
            title: "Auth",
          },
          trip: {
            description: "Trip planning features",
            title: "Trip",
          },
          booking: {
            description: "Booking and reservation features",
            title: "Booking",
          },
          search: {
            description: "Search functionality",
            title: "Search",
          },
          user: {
            description: "User management",
            title: "User",
          },
          notification: {
            description: "Notification system",
            title: "Notification",
          },
          payment: {
            description: "Payment processing",
            title: "Payment",
          },
          deps: {
            description: "Dependencies updates",
            title: "Dependencies",
          },
          config: {
            description: "Configuration files",
            title: "Config",
          },
          ci: {
            description: "CI/CD pipeline",
            title: "CI",
          },
          docker: {
            description: "Docker related changes",
            title: "Docker",
          },
          test: {
            description: "Testing infrastructure",
            title: "Test",
          },
          scripts: {
            description: "Build and utility scripts",
            title: "Scripts",
          },
          lint: {
            description: "Linting and formatting",
            title: "Lint",
          },
          docs: {
            description: "Documentation",
            title: "Docs",
          },
          readme: {
            description: "README file",
            title: "README",
          },
          claude: {
            description: "Claude Code configuration",
            title: "Claude",
          },
          db: {
            description: "Database changes",
            title: "Database",
          },
          cache: {
            description: "Caching system",
            title: "Cache",
          },
          queue: {
            description: "Queue system",
            title: "Queue",
          },
          shared: {
            description: "Shared/common code",
            title: "Shared",
          },
          utils: {
            description: "Utility functions",
            title: "Utils",
          },
        },
      },
      subject: {
        description: "Write a short, imperative tense description of the change (in English):",
      },
      body: {
        description: "Provide a longer description of the change (optional, in English):",
      },
      isBreaking: {
        description: "Are there any breaking changes?",
      },
      breaking: {
        description: "Describe the breaking changes:",
      },
      isIssueAffected: {
        description: "Does this change affect any open issues?",
      },
      issues: {
        description: 'Add issue references (e.g. "fix #123", "re #456"):',
      },
    },
  },
};
