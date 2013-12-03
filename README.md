# LLARateLimiter

LLARateLimiter is a rate limiter with a deligthful API. You can for example use it to prevent the users of your app hitting your API endpoint too often, even though you know there is no new data available.

## Usage

``` objc
[LLARateLimiter executeBlock:^{
    // Do stuff
} name:@"task" limit:30];

// Reset specific limit manually
[LLARateLimiter resetLimitForName:@"task"];

...

// Reset all limits
[LLARateLimiter resetAllLimits];
```

See the [header](LLARateLimiter/LLARateLimiter.h) for full documentation.

## Installation

[CocoaPods](http://cocoapods.org) is the recommended method of installing LLARateLimiter. Simply add the following line to your `Podfile`:

#### Podfile

```ruby
pod 'LLARateLimiter'
```

Otherwise you can just add the files under `LLARateLimiter` to your project.

## Requirements

LLARateLimiter is tested on iOS6 and iOS7 and requires ARC.

## Contact

Lukas Lipka

- http://github.com/lipka
- http://twitter.com/lipec
- http://lukaslipka.com

## License

LLARateLimiter is available under the [MIT license](LICENSE). See the LICENSE file for more info.
