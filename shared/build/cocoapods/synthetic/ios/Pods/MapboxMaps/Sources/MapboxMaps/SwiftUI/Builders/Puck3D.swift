/// Displays user location via 3D Puck.
///
/// Use a 3D model to display user location ``Map-swift.struct`` content.
///
/// ```swift
/// Map {
///     let model = Model(
///        uri: URL(string: /* url to glb model */),
///        orientation: [0, 0, 180] // orient source model to point the bearing property
///     )
///     Puck3D(model: model, bearing: .course)
/// }
/// ```
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
@_spi(Experimental)
public struct Puck3D: PrimitiveMapContent {
    private var configuration: Puck3DConfiguration
    private var bearing: PuckBearing?

    /// Creates puck.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public init(model: Model, bearing: PuckBearing?) {
        self.configuration = Puck3DConfiguration(model: model)
        self.bearing = bearing
    }

    /// The scale of the model.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelScale(_ modelScale: [Double]) -> Puck3D {
        copyAssigned(self, \.configuration.modelScale, .constant(modelScale))
    }

    /// The rotation of the model in euler angles [lon, lat, z].
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelRotation(_ modelRotation: [Double]) -> Puck3D {
        copyAssigned(self, \.configuration.modelRotation, .constant(modelRotation))
    }

    /// The opacity of the model used as the location puck
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelOpacity(_ modelOpacity: Double) -> Puck3D {
        copyAssigned(self, \.configuration.modelOpacity, .constant(modelOpacity))
    }

    /// Enable/disable shadow casting for the puck model
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelCastShadows(_ modelCastShadows: Bool) -> Puck3D {
        copyAssigned(self, \.configuration.modelCastShadows, .constant(modelCastShadows))
    }

    /// Enable/disable shadow receiving for the puck model
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelReceiveShadows(_ modelReceiveShadows: Bool) -> Puck3D {
        copyAssigned(self, \.configuration.modelReceiveShadows, .constant(modelReceiveShadows))
    }

    /// Defines scaling mode. Only applies to location-indicator type layers. Defaults to ``ModelScaleMode/viewport``.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelScaleMode(_ modelScaleMode: ModelScaleMode) -> Puck3D {
        copyAssigned(self, \.configuration.modelScaleMode, .constant(modelScaleMode))
    }

    /// Strength of the emission. 
    ///
    /// There is no emission for value 0. For value 1.0, only emissive component (no shading) is displayed and values above 1.0 produce light contribution to surrounding area, for some of the parts (e.g. windows).
    ///
    /// Default value is 1.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelEmissiveStrength(_ modelEmissiveStrength: Double) -> Puck3D {
        copyAssigned(self, \.configuration.modelEmissiveStrength, .constant(modelEmissiveStrength))
    }

    /// The scale of the model.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelScale(_ modelScale: Expression) -> Puck3D {
        copyAssigned(self, \.configuration.modelScale, .expression(modelScale))
    }

    /// The rotation of the model in euler angles [lon, lat, z].
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelRotation(_ modelRotation: Expression) -> Puck3D {
        copyAssigned(self, \.configuration.modelRotation, .expression(modelRotation))
    }

    /// The opacity of the model used as the location puck
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelOpacity(_ modelOpacity: Expression) -> Puck3D {
        copyAssigned(self, \.configuration.modelOpacity, .expression(modelOpacity))
    }

    /// Enable/disable shadow casting for the puck model
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelCastShadows(_ modelCastShadows: Expression) -> Puck3D {
        copyAssigned(self, \.configuration.modelCastShadows, .expression(modelCastShadows))
    }

    /// Enable/disable shadow receiving for the puck model
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelReceiveShadows(_ modelReceiveShadows: Expression) -> Puck3D {
        copyAssigned(self, \.configuration.modelReceiveShadows, .expression(modelReceiveShadows))
    }

    /// Defines scaling mode. Only applies to location-indicator type layers. Defaults to ``ModelScaleMode/viewport``.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelScaleMode(_ modelScaleMode: Expression) -> Puck3D {
        copyAssigned(self, \.configuration.modelScaleMode, .expression(modelScaleMode))
    }

    /// Strength of the emission.
    ///
    /// There is no emission for value 0. For value 1.0, only emissive component (no shading) is displayed and values above 1.0 produce light contribution to surrounding area, for some of the parts (e.g. windows).
    ///
    /// Default value is 1.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func modelEmissiveStrength(_ modelEmissiveStrength: Expression) -> Puck3D {
        copyAssigned(self, \.configuration.modelEmissiveStrength, .expression(modelEmissiveStrength))
    }

    func _visit(_ visitor: MapContentVisitor) {
        visitor.locationOptions = LocationOptions(
            puckType: .puck3D(configuration),
            puckBearing: bearing ?? .heading,
            puckBearingEnabled: bearing != nil)
    }
}
