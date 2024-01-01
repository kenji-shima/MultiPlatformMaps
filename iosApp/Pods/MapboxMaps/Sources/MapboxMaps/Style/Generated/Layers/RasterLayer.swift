// This file is generated.
import Foundation

/// Raster map textures such as satellite imagery.
///
/// - SeeAlso: [Mapbox Style Specification](https://www.mapbox.com/mapbox-gl-style-spec/#layers-raster)
public struct RasterLayer: Layer {

    // MARK: - Conformance to `Layer` protocol
    /// Unique layer name
    public var id: String

    /// Rendering type of this layer.
    public let type: LayerType

    /// An expression specifying conditions on source features.
    /// Only features that match the filter are displayed.
    public var filter: Expression?

    /// Name of a source description to be used for this layer.
    /// Required for all layer types except ``BackgroundLayer``, ``SkyLayer``, and ``LocationIndicatorLayer``.
    public var source: String?

    /// Layer to use from a vector tile source.
    ///
    /// Required for vector tile sources.
    /// Prohibited for all other source types, including GeoJSON sources.
    public var sourceLayer: String?
    
    /// The slot this layer is assigned to. If specified, and a slot with that name exists, it will be placed at that position in the layer order.
    public var slot: Slot?

    /// The minimum zoom level for the layer. At zoom levels less than the minzoom, the layer will be hidden.
    public var minZoom: Double?

    /// The maximum zoom level for the layer. At zoom levels equal to or greater than the maxzoom, the layer will be hidden.
    public var maxZoom: Double?

    /// Whether this layer is displayed.
    public var visibility: Value<Visibility>

    /// Increase or reduce the brightness of the image. The value is the maximum brightness.
    public var rasterBrightnessMax: Value<Double>?

    /// Transition options for `rasterBrightnessMax`.
    public var rasterBrightnessMaxTransition: StyleTransition?

    /// Increase or reduce the brightness of the image. The value is the minimum brightness.
    public var rasterBrightnessMin: Value<Double>?

    /// Transition options for `rasterBrightnessMin`.
    public var rasterBrightnessMinTransition: StyleTransition?

    /// Defines a color map by which to colorize a raster layer, parameterized by the `["raster-value"]` expression and evaluated at 1024 uniformly spaced steps over the range specified by `raster-color-range`.
    public var rasterColor: Value<StyleColor>?

    /// When `raster-color` is active, specifies the combination of source RGB channels used to compute the raster value. Computed using the equation `mix.r * src.r + mix.g * src.g + mix.b * src.b + mix.a`. The first three components specify the mix of source red, green, and blue channels, respectively. The fourth component serves as a constant offset and is *not* multipled by source alpha. Source alpha is instead carried through and applied as opacity to the colorized result. Default value corresponds to RGB luminosity.
    public var rasterColorMix: Value<[Double]>?

    /// Transition options for `rasterColorMix`.
    public var rasterColorMixTransition: StyleTransition?

    /// When `raster-color` is active, specifies the range over which `raster-color` is tabulated. Units correspond to the computed raster value via `raster-color-mix`.
    public var rasterColorRange: Value<[Double]>?

    /// Transition options for `rasterColorRange`.
    public var rasterColorRangeTransition: StyleTransition?

    /// Increase or reduce the contrast of the image.
    public var rasterContrast: Value<Double>?

    /// Transition options for `rasterContrast`.
    public var rasterContrastTransition: StyleTransition?

    /// Fade duration when a new tile is added.
    public var rasterFadeDuration: Value<Double>?

    /// Rotates hues around the color wheel.
    public var rasterHueRotate: Value<Double>?

    /// Transition options for `rasterHueRotate`.
    public var rasterHueRotateTransition: StyleTransition?

    /// The opacity at which the image will be drawn.
    public var rasterOpacity: Value<Double>?

    /// Transition options for `rasterOpacity`.
    public var rasterOpacityTransition: StyleTransition?

    /// The resampling/interpolation method to use for overscaling, also known as texture magnification filter
    public var rasterResampling: Value<RasterResampling>?

    /// Increase or reduce the saturation of the image.
    public var rasterSaturation: Value<Double>?

    /// Transition options for `rasterSaturation`.
    public var rasterSaturationTransition: StyleTransition?

    public init(id: String, source: String) {
        self.source = source
        self.id = id
        self.type = LayerType.raster
        self.visibility = .constant(.visible)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: RootCodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(filter, forKey: .filter)
        try container.encodeIfPresent(source, forKey: .source)
        try container.encodeIfPresent(sourceLayer, forKey: .sourceLayer)
        try container.encodeIfPresent(slot, forKey: .slot)
        try container.encodeIfPresent(minZoom, forKey: .minZoom)
        try container.encodeIfPresent(maxZoom, forKey: .maxZoom)

        var paintContainer = container.nestedContainer(keyedBy: PaintCodingKeys.self, forKey: .paint)
        try paintContainer.encodeIfPresent(rasterBrightnessMax, forKey: .rasterBrightnessMax)
        try paintContainer.encodeIfPresent(rasterBrightnessMaxTransition, forKey: .rasterBrightnessMaxTransition)
        try paintContainer.encodeIfPresent(rasterBrightnessMin, forKey: .rasterBrightnessMin)
        try paintContainer.encodeIfPresent(rasterBrightnessMinTransition, forKey: .rasterBrightnessMinTransition)
        try paintContainer.encodeIfPresent(rasterColor, forKey: .rasterColor)
        try paintContainer.encodeIfPresent(rasterColorMix, forKey: .rasterColorMix)
        try paintContainer.encodeIfPresent(rasterColorMixTransition, forKey: .rasterColorMixTransition)
        try paintContainer.encodeIfPresent(rasterColorRange, forKey: .rasterColorRange)
        try paintContainer.encodeIfPresent(rasterColorRangeTransition, forKey: .rasterColorRangeTransition)
        try paintContainer.encodeIfPresent(rasterContrast, forKey: .rasterContrast)
        try paintContainer.encodeIfPresent(rasterContrastTransition, forKey: .rasterContrastTransition)
        try paintContainer.encodeIfPresent(rasterFadeDuration, forKey: .rasterFadeDuration)
        try paintContainer.encodeIfPresent(rasterHueRotate, forKey: .rasterHueRotate)
        try paintContainer.encodeIfPresent(rasterHueRotateTransition, forKey: .rasterHueRotateTransition)
        try paintContainer.encodeIfPresent(rasterOpacity, forKey: .rasterOpacity)
        try paintContainer.encodeIfPresent(rasterOpacityTransition, forKey: .rasterOpacityTransition)
        try paintContainer.encodeIfPresent(rasterResampling, forKey: .rasterResampling)
        try paintContainer.encodeIfPresent(rasterSaturation, forKey: .rasterSaturation)
        try paintContainer.encodeIfPresent(rasterSaturationTransition, forKey: .rasterSaturationTransition)

        var layoutContainer = container.nestedContainer(keyedBy: LayoutCodingKeys.self, forKey: .layout)
        try layoutContainer.encode(visibility, forKey: .visibility)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(LayerType.self, forKey: .type)
        filter = try container.decodeIfPresent(Expression.self, forKey: .filter)
        source = try container.decodeIfPresent(String.self, forKey: .source)
        sourceLayer = try container.decodeIfPresent(String.self, forKey: .sourceLayer)
        slot = try container.decodeIfPresent(Slot.self, forKey: .slot)
        minZoom = try container.decodeIfPresent(Double.self, forKey: .minZoom)
        maxZoom = try container.decodeIfPresent(Double.self, forKey: .maxZoom)

        if let paintContainer = try? container.nestedContainer(keyedBy: PaintCodingKeys.self, forKey: .paint) {
            rasterBrightnessMax = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .rasterBrightnessMax)
            rasterBrightnessMaxTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .rasterBrightnessMaxTransition)
            rasterBrightnessMin = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .rasterBrightnessMin)
            rasterBrightnessMinTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .rasterBrightnessMinTransition)
            rasterColor = try paintContainer.decodeIfPresent(Value<StyleColor>.self, forKey: .rasterColor)
            rasterColorMix = try paintContainer.decodeIfPresent(Value<[Double]>.self, forKey: .rasterColorMix)
            rasterColorMixTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .rasterColorMixTransition)
            rasterColorRange = try paintContainer.decodeIfPresent(Value<[Double]>.self, forKey: .rasterColorRange)
            rasterColorRangeTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .rasterColorRangeTransition)
            rasterContrast = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .rasterContrast)
            rasterContrastTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .rasterContrastTransition)
            rasterFadeDuration = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .rasterFadeDuration)
            rasterHueRotate = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .rasterHueRotate)
            rasterHueRotateTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .rasterHueRotateTransition)
            rasterOpacity = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .rasterOpacity)
            rasterOpacityTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .rasterOpacityTransition)
            rasterResampling = try paintContainer.decodeIfPresent(Value<RasterResampling>.self, forKey: .rasterResampling)
            rasterSaturation = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .rasterSaturation)
            rasterSaturationTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .rasterSaturationTransition)
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
        case filter = "filter"
        case source = "source"
        case sourceLayer = "source-layer"
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
        case rasterBrightnessMax = "raster-brightness-max"
        case rasterBrightnessMaxTransition = "raster-brightness-max-transition"
        case rasterBrightnessMin = "raster-brightness-min"
        case rasterBrightnessMinTransition = "raster-brightness-min-transition"
        case rasterColor = "raster-color"
        case rasterColorMix = "raster-color-mix"
        case rasterColorMixTransition = "raster-color-mix-transition"
        case rasterColorRange = "raster-color-range"
        case rasterColorRangeTransition = "raster-color-range-transition"
        case rasterContrast = "raster-contrast"
        case rasterContrastTransition = "raster-contrast-transition"
        case rasterFadeDuration = "raster-fade-duration"
        case rasterHueRotate = "raster-hue-rotate"
        case rasterHueRotateTransition = "raster-hue-rotate-transition"
        case rasterOpacity = "raster-opacity"
        case rasterOpacityTransition = "raster-opacity-transition"
        case rasterResampling = "raster-resampling"
        case rasterSaturation = "raster-saturation"
        case rasterSaturationTransition = "raster-saturation-transition"
    }
}

// End of generated file.
