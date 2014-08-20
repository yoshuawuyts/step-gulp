# gulpjs
A wercker step to execute commands using [gulp][gulp].

You should have [Node][node] installed and `gulp` added to your `package.json`.

## Example Usage
In your [wercker.yml][wercker-yml] file under the `build` section:

``` bash
build:
  steps:
    - gulp:
        tasks: test
```

## Arguments
### tasks
- type: string
- optional: true
- description: Tasks which should be run. You can use spaces to specify multiple
tasks. If no tasks have been specified, then gulp will run the `default` task.
- example: `tasks: eslint buster`

### verbose
- type: boolean
- optional: true (default: false)
- description: Run gulp in verbose mode

## License
[MIT](https://tldrlegal.com/license/mit-license) ©
[Yoshua Wuyts](http://yoshuawuyts.com)

[gulp]: http://gulpjs.com
[node]: http://nodejs.org/download/
[wercker-yml]: http://devcenter.wercker.com/articles/werckeryml/
