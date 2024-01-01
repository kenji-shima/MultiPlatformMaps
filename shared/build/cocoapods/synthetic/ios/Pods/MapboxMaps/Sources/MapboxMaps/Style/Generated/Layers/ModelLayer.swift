// This file is generated.
import Foundation

/// A layer to render 3D Models.
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
@_spi(Experimental) public struct ModelLayer: Layer {

    // MARK: - Conformance to `Layer` protocol
    /// Unique layer name
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var id: String

    /// Rendering type of this layer.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public let type: LayerType

    /// An expression specifying conditions on source features.
    /// Only features that match the filter are displayed.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var filter: Expression?

    /// Name of a source description to be used for this layer.
    /// Required for all layer types except ``BackgroundLayer``, ``SkyLayer``, and ``LocationIndicatorLayer``.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var source: String?

    /// Layer to use from a vector tile source.
    ///
    /// Required for vector tile sources.
    /// Prohibited for all other source types, including GeoJSON sources.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var sourceLayer: String?
    
    /// The slot this layer is assigned to. If specified, and a slot with that name exists, it will be placed at that position in the layer order.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var slot: Slot?

    /// The minimum zoom level for the layer. At zoom levels less than the minzoom, the layer will be hidden.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var minZoom: Double?

    /// The maximum zoom level for the layer. At zoom levels equal to or greater than the maxzoom, the layer will be hidden.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var maxZoom: Double?

    /// Whether this layer is displayed.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var visibility: Value<Visibility>

    /// Model to render.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelId: Value<String>?

    /// Intensity of the ambient occlusion if present in the 3D model.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelAmbientOcclusionIntensity: Value<Double>?

    /// Transition options for `modelAmbientOcclusionIntensity`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelAmbientOcclusionIntensityTransition: StyleTransition?

    /// Enable/Disable shadow casting for this layer
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelCastShadows: Value<Bool>?

    /// The tint color of the model layer. model-color-mix-intensity (defaults to 0) defines tint(mix) intensity - this means that, this color is not used unless model-color-mix-intensity gets value greater than 0.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelColor: Value<StyleColor>?

    /// Transition options for `modelColor`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelColorTransition: StyleTransition?

    /// Intensity of model-color (on a scale from 0 to 1) in color mix with original 3D model's colors. Higher number will present a higher model-color contribution in mix.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelColorMixIntensity: Value<Double>?

    /// Transition options for `modelColorMixIntensity`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelColorMixIntensityTransition: StyleTransition?

    /// This parameter defines the range for the fade-out effect before an automatic content cutoff  on pitched map views. The automatic cutoff range is calculated according to the minimum required zoom level of the source and layer. The fade range is expressed in relation to the height of the map view. A value of 1.0 indicates that the content is faded to the same extent as the map's height in pixels, while a value close to zero represents a sharp cutoff. When the value is set to 0.0, the cutoff is completely disabled. Note: The property has no effect on the map if terrain is enabled.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelCutoffFadeRange: Value<Double>?

    /// Strength of the emission. There is no emission for value 0. For value 1.0, only emissive component (no shading) is displayed and values above 1.0 produce light contribution to surrounding area, for some of the parts (e.g. doors). Expressions that depend on measure-light are not supported when using GeoJSON or vector tile as the model layer source.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelEmissiveStrength: Value<Double>?

    /// Transition options for `modelEmissiveStrength`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelEmissiveStrengthTransition: StyleTransition?

    /// Emissive strength multiplier along model height (gradient begin, gradient end, value at begin, value at end, gradient curve power (logarithmic scale, curve power = pow(10, val)).
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelHeightBasedEmissiveStrengthMultiplier: Value<[Double]>?

    /// Transition options for `modelHeightBasedEmissiveStrengthMultiplier`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelHeightBasedEmissiveStrengthMultiplierTransition: StyleTransition?

    /// The opacity of the model layer.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelOpacity: Value<Double>?

    /// Transition options for `modelOpacity`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelOpacityTransition: StyleTransition?

    /// Enable/Disable shadow receiving for this layer
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelReceiveShadows: Value<Bool>?

    /// The rotation of the model in euler angles [lon, lat, z].
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelRotation: Value<[Double]>?

    /// Transition options for `modelRotation`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelRotationTransition: StyleTransition?

    /// Material roughness. Material is fully smooth for value 0, and fully rough for value 1. Affects only layers using batched-model source.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelRoughness: Value<Double>?

    /// Transition options for `modelRoughness`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelRoughnessTransition: StyleTransition?

    /// The scale of the model.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelScale: Value<[Double]>?

    /// Transition options for `modelScale`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelScaleTransition: StyleTransition?

    /// Defines scaling mode. Only applies to location-indicator type layers.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelScaleMode: Value<ModelScaleMode>?

    /// The translation of the model in meters in form of [longitudal, latitudal, altitude] offsets.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelTranslation: Value<[Double]>?

    /// Transition options for `modelTranslation`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelTranslationTransition: StyleTransition?

    /// Defines rendering behavior of model in respect to other 3D scene objects.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public var modelType: Value<ModelType>?

#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public init(id: String, source: String) {
        self.source = source
        self.id = id
        self.type = LayerType.model
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
        try paintContainer.encodeIfPresent(modelAmbientOcclusionIntensity, forKey: .modelAmbientOcclusionIntensity)
        try paintContainer.encodeIfPresent(modelAmbientOcclusionIntensityTransition, forKey: .modelAmbientOcclusionIntensityTransition)
        try paintContainer.encodeIfPresent(modelCastShadows, forKey: .modelCastShadows)
        try paintContainer.encodeIfPresent(modelColor, forKey: .modelColor)
        try paintContainer.encodeIfPresent(modelColorTransition, forKey: .modelColorTransition)
        try paintContainer.encodeIfPresent(modelColorMixIntensity, forKey: .modelColorMixIntensity)
        try paintContainer.encodeIfPresent(modelColorMixIntensityTransition, forKey: .modelColorMixIntensityTransition)
        try paintContainer.encodeIfPresent(modelCutoffFadeRange, forKey: .modelCutoffFadeRange)
        try paintContainer.encodeIfPresent(modelEmissiveStrength, forKey: .modelEmissiveStrength)
        try paintContainer.encodeIfPresent(modelEmissiveStrengthTransition, forKey: .modelEmissiveStrengthTransition)
        try paintContainer.encodeIfPresent(modelHeightBasedEmissiveStrengthMultiplier, forKey: .modelHeightBasedEmissiveStrengthMultiplier)
        try paintContainer.encodeIfPresent(modelHeightBasedEmissiveStrengthMultiplierTransition, forKey: .modelHeightBasedEmissiveStrengthMultiplierTransition)
        try paintContainer.encodeIfPresent(modelOpacity, forKey: .modelOpacity)
        try paintContainer.encodeIfPresent(modelOpacityTransition, forKey: .modelOpacityTransition)
        try paintContainer.encodeIfPresent(modelReceiveShadows, forKey: .modelReceiveShadows)
        try paintContainer.encodeIfPresent(modelRotation, forKey: .modelRotation)
        try paintContainer.encodeIfPresent(modelRotationTransition, forKey: .modelRotationTransition)
        try paintContainer.encodeIfPresent(modelRoughness, forKey: .modelRoughness)
        try paintContainer.encodeIfPresent(modelRoughnessTransition, forKey: .modelRoughnessTransition)
        try paintContainer.encodeIfPresent(modelScale, forKey: .modelScale)
        try paintContainer.encodeIfPresent(modelScaleTransition, forKey: .modelScaleTransition)
        try paintContainer.encodeIfPresent(modelScaleMode, forKey: .modelScaleMode)
        try paintContainer.encodeIfPresent(modelTranslation, forKey: .modelTranslation)
        try paintContainer.encodeIfPresent(modelTranslationTransition, forKey: .modelTranslationTransition)
        try paintContainer.encodeIfPresent(modelType, forKey: .modelType)

        var layoutContainer = container.nestedContainer(keyedBy: LayoutCodingKeys.self, forKey: .layout)
        try layoutContainer.encode(visibility, forKey: .visibility)
        try layoutContainer.encodeIfPresent(modelId, forKey: .modelId)
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
            modelAmbientOcclusionIntensity = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .modelAmbientOcclusionIntensity)
            modelAmbientOcclusionIntensityTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .modelAmbientOcclusionIntensityTransition)
            modelCastShadows = try paintContainer.decodeIfPresent(Value<Bool>.self, forKey: .modelCastShadows)
            modelColor = try paintContainer.decodeIfPresent(Value<StyleColor>.self, forKey: .modelColor)
            modelColorTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .modelColorTransition)
            modelColorMixIntensity = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .modelColorMixIntensity)
            modelColorMixIntensityTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .modelColorMixIntensityTransition)
            modelCutoffFadeRange = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .modelCutoffFadeRange)
            modelEmissiveStrength = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .modelEmissiveStrength)
            modelEmissiveStrengthTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .modelEmissiveStrengthTransition)
            modelHeightBasedEmissiveStrengthMultiplier = try paintContainer.decodeIfPresent(Value<[Double]>.self, forKey: .modelHeightBasedEmissiveStrengthMultiplier)
            modelHeightBasedEmissiveStrengthMultiplierTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .modelHeightBasedEmissiveStrengthMultiplierTransition)
            modelOpacity = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .modelOpacity)
            modelOpacityTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .modelOpacityTransition)
            modelReceiveShadows = try paintContainer.decodeIfPresent(Value<Bool>.self, forKey: .modelReceiveShadows)
            modelRotation = try paintContainer.decodeIfPresent(Value<[Double]>.self, forKey: .modelRotation)
            modelRotationTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .modelRotationTransition)
            modelRoughness = try paintContainer.decodeIfPresent(Value<Double>.self, forKey: .modelRoughness)
            modelRoughnessTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .modelRoughnessTransition)
            modelScale = try paintContainer.decodeIfPresent(Value<[Double]>.self, forKey: .modelScale)
            modelScaleTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .modelScaleTransition)
            modelScaleMode = try paintContainer.decodeIfPresent(Value<ModelScaleMode>.self, forKey: .modelScaleMode)
            modelTranslation = try paintContainer.decodeIfPresent(Value<[Double]>.self, forKey: .modelTranslation)
            modelTranslationTransition = try paintContainer.decodeIfPresent(StyleTransition.self, forKey: .modelTranslationTransition)
            modelType = try paintContainer.decodeIfPresent(Value<ModelType>.self, forKey: .modelType)
        }

        var visibilityEncoded: Value<Visibility>?
        if let layoutContainer = try? container.nestedContainer(keyedBy: LayoutCodingKeys.self, forKey: .layout) {
            visibilityEncoded = try layoutContainer.decodeIfPresent(Value<Visibility>.self, forKey: .visibility)
            modelId = try layoutContainer.decodeIfPresent(Value<String>.self, forKey: .modelId)
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
        case modelId = "model-id"
        case visibility = "visibility"
    }

    enum PaintCodingKeys: String, CodingKey {
        case modelAmbientOcclusionIntensity = "model-ambient-occlusion-intensity"
        case modelAmbientOcclusionIntensityTransition = "model-ambient-occlusion-intensity-transition"
        case modelCastShadows = "model-cast-shadows"
        case modelColor = "model-color"
        case modelColorTransition = "model-color-transition"
        case modelColorMixIntensity = "model-color-mix-intensity"
        case modelColorMixIntensityTransition = "model-color-mix-intensity-transition"
        case modelCutoffFadeRange = "model-cutoff-fade-range"
        case modelEmissiveStrength = "model-emissive-strength"
        case modelEmissiveStrengthTransition = "model-emissive-strength-transition"
        case modelHeightBasedEmissiveStrengthMultiplier = "model-height-based-emissive-strength-multiplier"
        case modelHeightBasedEmissiveStrengthMultiplierTransition = "model-height-based-emissive-strength-multiplier-transition"
        case modelOpacity = "model-opacity"
        case modelOpacityTransition = "model-opacity-transition"
        case modelReceiveShadows = "model-receive-shadows"
        case modelRotation = "model-rotation"
        case modelRotationTransition = "model-rotation-transition"
        case modelRoughness = "model-roughness"
        case modelRoughnessTransition = "model-roughness-transition"
        case modelScale = "model-scale"
        case modelScaleTransition = "model-scale-transition"
        case modelScaleMode = "model-scale-mode"
        case modelTranslation = "model-translation"
        case modelTranslationTransition = "model-translation-transition"
        case modelType = "model-type"
    }
}

// End of generated file.
