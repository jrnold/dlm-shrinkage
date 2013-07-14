# Stan Macros Collection

*Stan* (as of version 1.3.0) does not support user-defined functions.
One way to approximate user-defined functions and create reusable code
is by defining macros and
 
This project contains


# Using

Using CPP will add another step to your workflow. The C pre-processor
must be run on the file in order to expand the macros and generate
valid *Stan* code.

I use the following naming conventions for files:

- `*.stan` Stan model 
- `*.stanpp` Stan model containing macros
- `*.stanh` File containing macro definitions for Stan code.

Suppose that `foo.stanpp` is a *Stan* model containing macros. 
To generate a valid *Stan* model file named `foo.stan`, run it through the C pre-processor,

```console
cpp -I/path/to/headers -w -undef -Wundef -nostdinc -std=c11 -p foo.stanpp foo.stan
```

A makefile rule for this looks like this,

```makefile
STAN_HEADERS = /path/to/headers

%.stan : %.stanpp
	cpp -I$(STAN_HEADERS) -w -undef -Wundef -nostdinc -std=c11 -P $< $@
```

# Documentation

All macros names are ALL CAPS with a leading `_`; this means they are invalid *Stan* variable or function names, making it easier to catch errors.

## _JEFFREYS

`_JEFFREYS(x)` : The Jeffreys prior for variance or scale. This is an improper distribution.  Add $1 / x$ to the log-posterior.

## _MAKE_SYMMETRIC

`_MAKE_SYMMETRIC(x)` : If `x` is a matrix, ensure that it is symmeteric with the transformation `0.5 * (x + x')`.

## _TRIANGLE_LOG

`_TRIANGLE_LOG(y)`. The density of the triangle log. `log1m(fabs(y))`.
This assumes that `y` is defined as a bounded variable, e.g.
`real<lower=a, upper=b> y;`.

## _KALMANF

