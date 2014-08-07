# Guard-Slim Changelog

## 0.1.1 - August 7, 2014
- Add a verbose option to show additional output from guard_slim
- Add slim: {plugins: 'name'} option to load slim plugins into the compilation context
- Show backtrace if we rescue StandardError or Exception so we know where it came from.

## 0.1.0 - August 7, 2014
- Update to work with Guard 2.x and Slim 2.x
- Respect :input folder on run_all
- Deprecate :input_root and :output_root in favor of :input and :output
