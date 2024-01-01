// This file is generated.
import Foundation

/// A spherical dome around the map that is always rendered behind all other layers.
/// Warning: As of v10.6.0, ``Atmosphere`` is the preferred method for atmospheric styling. Sky layer is not supported by the globe projection, and will be phased out in future major release.
///
/// - SeeAlso: [Mapbox Style Specification](https://www.mapbox.com/mapbox-gl-style-spec/#layers-sky)
public struct SkyLayer: Layer {

    // MARK: - Conformance to `Layer` protocol
    /// Unique layer name
    public var id: String

    /// Rendering type of this layer.
    public let type: LayerType

    /// The slot this layer is assigned to. If specified, and a slot with that name exists, it will be placed at that position in the layer order.
    public var slot: Slot?

    /// The minimum zoom level for the layer. At zoom levels less than the minzoom, the layer will be hidden.
    public var minZoom: Double?

    /// The maximum zoom level for the layer. At zoom levels equal to or greater than the maxzoom, the layer will be hidden.
    public var maxZoom: Double?

    /// Whether this layer is displayed.
    public var visibility: Value<Visibility>

    /// A color used to tweak the main atmospheric scattering coefficients. Using white applies the default coefficients giving the natural blue color to the atmosphere. This color affects how heavily the corresponding wavelength is represented during scattering. The alpha channel describes the density of the atmosphere, with 1 maximum density and 0 no density.
    public var skyAtmosphereColor: Value<StyleColor>?

    /// A color applied to the atmosphere sun halo. The alpha channel describes how strongly the sun halo is represented in an atmosphere sky layer.
    public var skyAtmosphereHaloColor: Value<StyleColor>?

    /// Position of the sun center [a azimuthal angle, p polar angle]. The azimuthal angle indicates the position of the sun relative to 0 degree north, where degrees proceed clockwise. The polar angle indicates the height of the sun, where 0 degree is directly above, at zenith, and 90 degree at the horizon. When this property is ommitted, the sun center is directly inherited from the light position.
    public var skyAtmosphereSun: Value<[Double]>?

    /// Intensity of the sun as a light source in the atmosphere (on a scale from 0 to a 100). Setting higher values will brighten up the sky.
    public var skyAtmosphereSunIntensity: Value<Double>?

    /// Defines a radial color gradient with which to color the sky. The color values can be interpolated with an expression using `sky-radial-progress`. The range [0, 1] for the interpolant covers a radial distance (in degrees) of [0, `sky-gradient-radius`] centered at the position specified by `sky-gradient-center`.
    public var skyGradient: Value<StyleColor>?

    /// Position of the gradient center [a azimuthal angle, p polar angle]. The azimuthal angle indicates the position of the gradient center relative to 0 degree north, where degrees proceed clockwise. The polar angle indicates the height of the gradient center, where 0 degree is directly above, at zenith, and 90 degree at the horizon.
    public var skyGradientCenter: Value<[Double]>?

    /// The angular distance (measured in degrees) from `sky-gradient-center` up to which the gradient extends. A value of 180 causes the gradient to wrap around to the opposite direction from `sky-gradient-center`.
    public var skyGradientRadius: Value<Double>?

    /// The opacity of the entire sky layer.
    public var skyOpacity: Value<Double>?

    /// Transition options for `skyOpacity`.
    public var skyOpacityTransition: StyleTransition?

    /// The type of the sky
    public var skyType: Value<SkyType>?

    public init(id: String) {
        self.id = id
        self.type = LayerType.sky
        self.visibility = .constant(.visible)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: RootCodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(slot, forKey: .slot)
        try container.encodeIfPresent(minZoom, forKey: .minZoom)
        try container.encodeIfPresent(maxZoom, forKey: .maxZoom)

        var paintContainer = container.nestedContainer(keyedBy: PaintCodingKeys.self, forKey: .paint)
        try paintContainer.encodeIfPresent(skyAtmosphereColor, forKey: .skyAtmosphereColor)
        try paintContainer.encodeIfPresent(skyAtmosphereHaloColor, forKey: .skyAtmosphereHaloColor)
        try paintContainer.encodeIfPresent(skyAtmosphereSun, forKey: .skyAtmosphereSun)
        try paintContainer.encodeIfPresent(skyAtmosphereSunIntensity, forKey: .skyAtmosphereSunIntensity)
        try paintContainer.encodeIfPresent(skyGradient, forKey: .skyGradient)
        try paintContainer.encodeIfPresent(skyGradientCenter, forKey: .skyGradientCenter)
        try paintContainer.encodeIfPresent(skyGradientRadius, forKey: .skyGradientRadius)
        try paintContainer.encodeIfPresent(skyOpacity, forKey: .skyOpacity)
        try paintContainer.encodeIfPresent(skyOpacityTransition, forKey: .skyOpacityTransition)
        try paintContainer.encodeIfPresent(skyType, forKey: .skyType)

        var layoutContainer = container.nestedContainer(keyedBy: LayoutCodingKeys.self, forKey: .layout)
        try layoutContainer.encode(visibility, forKey: .visibility)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(LayerType.self, forKey: .type)
        slot = try container.decodeIfPresent(Slot.self, forKey: .slot)
        minZoom = try container.decodeIfPresent(Double.self, forKey: .minZoom)
        maxZoom = try container.decodeIfPresent(Double.self, forKey: .maxZoom)

        if let paintContainer = try? container.nestedContainer(keyedBy: PaintCodingKeys.self, forKey: .paint) {
            skyAtmosphereColor = try paintContainer.decodeIfPresent(Value<StyleColor>.self, forKey: .skyAtmosphereColor)
            skyAtmosphereHaloColor = try paintContainer.decodeIfPresent(Value<StyleColor>.self, forKey: .skyAtmosphereHaloColor)
            skyAtmosphereSun = try paintContainer.decodeIfPresent(Value<[Double]>.self, forKey: .skyAtmosphereSun)
            skyAtmosphereSunIntensity = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .skyAtmosphereSunIntensity)
            skyGradient = try paintContainer.decodeIfPresent(Value<StyleColor>.self, forKey: .skyGradient)
            skyGradientCenter = try paintContainer.decodeIfPresent(Value<[Double]>.self, forKey: .skyGradientCenter)
            skyGradientRadius = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .skyGradientRadius)
            skyOpacity = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .skyOpacity)
            skyOpacityTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .skyOpacityTransition)
            skyType = try paintContainer.decodeIfPresent(Value<SkyType>.self, forKey: .skyType)
        }

        var visibilityEncoded: Value<Visibility>?
        if let layoutContainer = try? container.nestedContainer(keyedBy: LayoutCodingKeys.self, forKey: .layout) {
            visibilityEncoded = try layoutContainer.decodeIfPresent(Value<Visibility>.self, forKey: .visibility)
        }
        visibility = visibilityEncoded ?? .constant(.visible)
    }

    enum RootCodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case slot = "slot"
        case minZoom = "minzoom"
        case maxZoom = "maxzoom"
        case layout = "layout"
        case paint = "paint"
    }

    enum LayoutCodingKeys: String, CodingKey {
        case visibility = "visibility"
    }

    enum PaintCodingKeys: String, CodingKey {
        case skyAtmosphereColor = "sky-atmosphere-color"
        case skyAtmosphereHaloColor = "sky-atmosphere-halo-color"
        case skyAtmosphereSun = "sky-atmosphere-sun"
        case skyAtmosphereSunIntensity = "sky-atmosphere-sun-intensity"
        case skyGradient = "sky-gradient"
        case skyGradientCenter = "sky-gradient-center"
        case skyGradientRadius = "sky-gradient-radius"
        case skyOpacity = "sky-opacity"
        case skyOpacityTransition = "sky-opacity-transition"
        case skyType = "sky-type"
    }
}

// End of generated file.
