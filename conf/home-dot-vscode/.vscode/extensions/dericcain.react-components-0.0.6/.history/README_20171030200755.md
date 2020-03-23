# React Components
Tired of typing the same ole' stuff 1,032 times a day? React Components saves you time be scaffolding out your React Components. When you create a React component, you can also have a test created with it, with a Jest snapshot test already created 😃 

![React Components](/screenshot.gif?raw=true "React Components")

## Installation
You can install the plugin by searching for react-components in the Visual Studio Code Marketplace
> or
1. Open Visual Studio Code
2. Launch Quick Open (⌘+P), paste ext install `react-components`, and press enter.

## Features
Right from the command palette, or even better, a shortcut, have a component created for you that is already scaffolded out. If you want tests created alongside your component, all you have to do is configure the settings to do so. Right now, you can create `class` based and `functional` components. More will be added as they are needed.

## Configuration
```JSON
{
	"react-components.root": "<root>/src/components", // use <root> and <component>. <root> is project root and <component> is the component's path (the component that you are creating)
	"react-components.fileExtension": ".js", // .js, .jsx
	"react-components.openAfterCreate": true, // true, false
	"react-components.tests": true, // true, false Create a test with your component
	"react-components.testsRoot": "<component>/__tests__", // use <root> or <component> to give a path for the test location
	"react-components.testsNameAppend": ".test" // append this to the end of the file so it can be Component.test.js or component_test.js
}
```

## Issues
If you see an issue, please submit it on Github. Even better, fix it and submit a pull request. 

## Contributing
I know this package can be better and I have plans for it to be. If you want to chip in, here are a few things that I would like to accomplish. By all means, this is not an exhaustive list and I would love your input of ways you think it could be better.

- [ ] Add ability to use test templates. See #1
- [ ] Add the ability to create tests only (should be very easy). See #2
- [ ] Add ability to take lowercase file names and automatically create create CamelCase or snake_case file names from them. This may be tricky. See #3
- [ ] Add ability to have lifecycle methods in the created component. See #4
- [ ] Extract some code from a file into its own component. See #5
- [ ] Add test. See #6

If you you want to help, please feel free create an issue and talk about what you want to change/fix/add. Once we have discused the changes that need to be made, fork the repo, make the changes and submit a pull request. Make sure that your code is linted before submitting the pull request.

**If you have any questions about anything at all, please do not hesitate to reach out.**

