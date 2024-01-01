#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "calendar" asset catalog image resource.
static NSString * const ACImageNameCalendar AC_SWIFT_PRIVATE = @"calendar";

/// The "dest-pin" asset catalog image resource.
static NSString * const ACImageNameDestPin AC_SWIFT_PRIVATE = @"dest-pin";

/// The "drop" asset catalog image resource.
static NSString * const ACImageNameDrop AC_SWIFT_PRIVATE = @"drop";

/// The "temperature" asset catalog image resource.
static NSString * const ACImageNameTemperature AC_SWIFT_PRIVATE = @"temperature";

/// The "temperature-sensor" asset catalog image resource.
static NSString * const ACImageNameTemperatureSensor AC_SWIFT_PRIVATE = @"temperature-sensor";

/// The "thermometer" asset catalog image resource.
static NSString * const ACImageNameThermometer AC_SWIFT_PRIVATE = @"thermometer";

#undef AC_SWIFT_PRIVATE