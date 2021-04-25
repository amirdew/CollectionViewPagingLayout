//
//  WeatherPage.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 14/04/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

import Foundation

enum WeatherPage: String, CaseIterable, Identifiable {
    case sun
    case lightning
    case tornado
    case moon
    case snow

    var id: String {
        rawValue
    }

    var imageName: String {
        switch self {
        case .sun:
            return "sun.max.fill"
        case .lightning:
            return "cloud.bolt.rain.fill"
        case .moon:
            return "moon.stars.fill"
        case .tornado:
            return "tornado"
        case .snow:
            return "snow"
        }
    }

    var name: String {
        rawValue.prefix(1).capitalized + rawValue.dropFirst()
    }
}

extension WeatherPage {
    struct Content {
        let items: [Item]

        enum Item {
            case text(String)
            case image(String)
        }
    }
}

// swiftlint:disable line_length
extension WeatherPage {
    var content: Content {
        switch self {
        case .sun:
            return .init(items: [
                .text(
                    """
                    The Sun is the star at the center of the Solar System. It is a nearly perfect sphere of hot plasma, heated to incandescence by nuclear fusion reactions in its core, radiating the energy mainly as visible light and infrared radiation.
                    It is by far the most important source of energy for life on Earth.
                    Its diameter is about 1.39 million kilometres (864,000 miles), or 109 times that of Earth.
                    Its mass is about 330,000 times that of Earth, and accounts for about 99.86% of the total mass of the Solar System.
                    """
                ),
                .image("sun1"),
                .text(
                    """
                    The Sun is a G-type main-sequence star (G2V) based on its spectral class. As such, it is informally and not completely accurately referred to as a yellow dwarf (its light is closer to white than yellow).
                    It formed approximately 4.6 billion years ago from the gravitational collapse of matter within a region of a large molecular cloud.
                    """
                ),
                .image("sun2")
            ])
        case .lightning:
            return .init(items: [
                .text(
                    """
                    Lightning is a naturally occurring electrostatic discharge during which two electrically charged regions in the atmosphere or ground temporarily equalize themselves, causing the instantaneous release of as much as one gigajoule of energy.
                    This discharge may produce a wide range of electromagnetic radiation, from very hot plasma created by the rapid movement of electrons to brilliant flashes of visible light in the form of black-body radiation. Lightning causes thunder, a sound from the shock wave which develops as gases in the vicinity of the discharge experience a sudden increase in pressure.
                    """
                ),
                .image("lightning1"),
                .text(
                    """
                    The three main kinds of lightning are distinguished by where they occur: either inside a single thundercloud, between two different clouds, or between a cloud and the ground.
                    Many other observational variants are recognized, including "heat lightning", which can be seen from a great distance but not heard; dry lightning, which can cause forest fires; and ball lightning, which is rarely observed scientifically.
                    """
                ),
                .image("lightning2")
            ])
        case .tornado:
            return .init(items: [
                .text(
                    """
                    A tornado is a violently rotating column of air that is in contact with both the surface of the Earth and a cumulonimbus cloud or, in rare cases, the base of a cumulus cloud.
                    The windstorm is often referred to as a twister, whirlwind or cyclone, although the word cyclone is used in meteorology to name a weather system with a low-pressure area in the center around which, from an observer looking down toward the surface of the earth, winds blow counterclockwise in the Northern Hemisphere and clockwise in the Southern.
                    """
                ),
                .image("tornado1"),
                .text(
                    """
                    Various types of tornadoes include the multiple vortex tornado, landspout, and waterspout. Waterspouts are characterized by a spiraling funnel-shaped wind current, connecting to a large cumulus or cumulonimbus cloud. They are generally classified as non-supercellular tornadoes that develop over bodies of water, but there is disagreement over whether to classify them as true tornadoes.
                    """
                ),
                .image("tornado2")
            ])
        case .moon:
            return .init(items: [
                .text(
                    """
                    The Moon is Earth's only proper natural satellite. At one-quarter the diameter of Earth (comparable to the width of Australia), it is the largest natural satellite in the Solar System relative to the size of its planet, and the fifth largest satellite in the Solar System overall (larger than any dwarf planet).
                    """
                ),
                .image("moon1"),
                .text(
                    """
                    The Moon's orbit around Earth has a sidereal period of 27.3 days, and a synodic period of 29.5 days. The synodic period drives its lunar phases, which form the basis for the months of a lunar calendar. The Moon is tidally locked to Earth, which means that the length of a full rotation of the Moon on its own axis (a lunar day) is the same as the synodic period, resulting in its same side (the near side) always facing Earth. That said, 59% of the total lunar surface can be seen from Earth through shifts in perspective (its libration).
                    """
                ),
                .image("moon2")
            ])
        case .snow:
            return .init(items: [
                .text(
                    """
                    Snow comprises individual ice crystals that grow while suspended in the atmosphere—usually within clouds—and then fall, accumulating on the ground where they undergo further changes.[2] It consists of frozen crystalline water throughout its life cycle, starting when, under suitable conditions, the ice crystals form in the atmosphere, increase to millimeter size, precipitate and accumulate on surfaces, then metamorphose in place, and ultimately melt, slide or sublimate away.
                    """
                ),
                .image("snow1"),
                .text(
                    """
                    Major snow-prone areas include the polar regions, the northernmost half of the Northern Hemisphere and mountainous regions worldwide with sufficient moisture and cold temperatures. In the Southern Hemisphere, snow is confined primarily to mountainous areas, apart from Antarctica.
                    """
                ),
                .image("snow2")
            ])
        }
    }
}
