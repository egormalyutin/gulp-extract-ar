# gulp-extract-ar
Extract ar archives with Gulp.

```js
gulp = require('gulp')
ar   = require('ar')

gulp.task('default', function() {
	gulp.src('archive.a')
		.pipe(ar())
		.pipe(gulp.dest('build'))
})

```
