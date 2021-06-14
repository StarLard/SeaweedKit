import XCTest
@testable import StormGlassKit

final class StormGlassKitTests: XCTestCase {
    func testMetadataDecoding() throws {
        let metadata = try JSONDecoder().decode(Weather.Metadata.self, from: metaData)
        XCTAssertEqual(metadata.cost, 1)
        XCTAssertEqual(metadata.requestCount, 6)
        XCTAssertEqual(metadata.start, "2021-06-14 06:00")
        XCTAssertTrue(metadata.parameters.contains(.swellHeight))
        XCTAssertTrue(metadata.sources.contains(.noaa))
    }
    
    func testHourDecoding() throws {
        let hour = try JSONDecoder().decode(Weather.Hour.self, from: hourData)
        XCTAssertEqual(hour.time, Date(timeIntervalSince1970: 1623650400))
        XCTAssertEqual(hour.data.count, 7)
        XCTAssertEqual(hour.data[.swellHeight]?[.noaa], 0.26)
        XCTAssertEqual(hour.data[.waterTemperature]?[.stormGlass], 25.55)
        XCTAssertNil(hour.data[.waterTemperature]?[.noaa])
    }
    
    func testWeatherDecoding() throws {
        let weather = try JSONDecoder().decode(Weather.self, from: weatherData)
        XCTAssertEqual(weather.hours.count, 2)
        XCTAssertEqual(weather.hours.first?.data[.waveHeight]?[.noaa], 0.56)
        XCTAssertEqual(weather.meta.cost, 1)
    }
    
    private let metaData: Data = """
    {
        "cost": 1,
        "dailyQuota": 50,
        "end": "2021-06-14 07:16",
        "lat": 19.64,
        "lng": -155.9969,
        "params": [
            "airTemperature",
            "currentDirection",
            "currentSpeed",
            "swellDirection",
            "swellHeight",
            "secondarySwellHeight",
            "secondarySwellDirection",
            "waterTemperature",
            "waveHeight"
        ],
        "requestCount": 6,
        "source": [
            "noaa"
        ],
        "start": "2021-06-14 06:00"
    }
    """.data(using: .utf8)!
    
    private let hourData: Data = """
    {
        "airTemperature": {
            "noaa": 23.59
        },
        "secondarySwellDirection": {
            "noaa": 187.6
        },
        "secondarySwellHeight": {
            "noaa": 0.29
        },
        "swellDirection": {
            "noaa": 206.12
        },
        "swellHeight": {
            "noaa": 0.26
        },
        "time": "2021-06-14T06:00:00+00:00",
        "waterTemperature": {
            "sg": 25.55
        },
        "waveHeight": {
            "noaa": 0.56
        }
    }
    """.data(using: .utf8)!
    
    private let weatherData: Data = """
    {
        "hours": [
            {
                "airTemperature": {
                    "noaa": 23.59
                },
                "secondarySwellDirection": {
                    "noaa": 187.6
                },
                "secondarySwellHeight": {
                    "noaa": 0.29
                },
                "swellDirection": {
                    "noaa": 206.12
                },
                "swellHeight": {
                    "noaa": 0.26
                },
                "time": "2021-06-14T06:00:00+00:00",
                "waterTemperature": {
                    "noaa": 25.55
                },
                "waveHeight": {
                    "noaa": 0.56
                }
            },
            {
                "airTemperature": {
                    "noaa": 23.62
                },
                "secondarySwellDirection": {
                    "noaa": 184.31
                },
                "secondarySwellHeight": {
                    "noaa": 0.29
                },
                "swellDirection": {
                    "noaa": 203.61
                },
                "swellHeight": {
                    "noaa": 0.27
                },
                "time": "2021-06-14T07:00:00+00:00",
                "waterTemperature": {
                    "noaa": 25.56
                },
                "waveHeight": {
                    "noaa": 0.56
                }
            }
        ],
        "meta": {
            "cost": 1,
            "dailyQuota": 50,
            "end": "2021-06-14 07:16",
            "lat": 19.64,
            "lng": -155.9969,
            "params": [
                "airTemperature",
                "currentDirection",
                "currentSpeed",
                "swellDirection",
                "swellHeight",
                "secondarySwellHeight",
                "secondarySwellDirection",
                "waterTemperature",
                "waveHeight"
            ],
            "requestCount": 6,
            "source": [
                "noaa"
            ],
            "start": "2021-06-14 06:00"
        }
    }
    """.data(using: .utf8)!
}
