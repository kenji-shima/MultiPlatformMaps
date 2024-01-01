// This file is generated

/// Displays a group of ``CircleAnnotation``s.
///
/// When multiple annotation grouped, they render by a single layer. This makes annotations more performant and
/// allows to modify group-specific parameters.  For example, you can define layer slot with ``slot(_:)``.
///
/// - Note: `CircleAnnotationGroup` is a SwiftUI analog to ``CircleAnnotationManager``.
///
/// The group can be created with dynamic data, or static data. When first method is used, you specify array of identified data and provide a closure that creates a ``CircleAnnotation`` from that data, similar to ``ForEvery``:
///
/// ```swift
/// Map {
///     CircleAnnotationGroup(pivots) { pivot in
///         CircleAnnotation(centerCoordinate: pivot.coordinate)
///             .circleColor("white")
///             .circleRadius(10)
///     }
/// }
/// .slot("top")
/// ```
///
/// When the number of annotations is static, you use static that groups one or more annotations:
///
/// ```swift
/// Map {
///     CircleAnnotationGroup {
///         CircleAnnotation(centerCoordinate: route.startCoordinate)
///             .circleColor("white")
///             .circleRadius(10)
///         CircleAnnotation(centerCoordinate: route.endCoordinate)
///             .circleColor("gray")
///             .circleRadius(10)
///     }
///     .slot("top")
/// }
/// ```
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
@_spi(Experimental)
public struct CircleAnnotationGroup<Data: RandomAccessCollection, ID: Hashable>: PrimitiveMapContent {
    let store: ForEvery<CircleAnnotation, Data, ID>

    /// Creates a group that identifies data by given key path.
    ///
    /// - Parameters:
    ///     - data: Collection of data.
    ///     - id: Data identifier key path.
    ///     - content: A closure that creates annotation for a given data item.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (Data.Element) -> CircleAnnotation) {
        store = ForEvery(data: data, id: id, content: content)
    }

    /// Creates a group from identifiable data.
    ///
    /// - Parameters:
    ///     - data: Collection of identifiable data.
    ///     - content: A closure that creates annotation for a given data item.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    @available(iOS 13.0, *)
    public init(_ data: Data, content: @escaping (Data.Element) -> CircleAnnotation) where Data.Element: Identifiable, Data.Element.ID == ID {
        self.init(data, id: \.id, content: content)
    }

    /// Creates static group.
    ///
    /// - Parameters:
    ///     - content: A builder closure that creates annotations.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public init(@ArrayBuilder<CircleAnnotation> content: @escaping () -> [CircleAnnotation?])
        where Data == Array<(Int, CircleAnnotation)>, ID == Int {
        let annotations = content().enumerated().compactMap {
            $0.element == nil ? nil : ($0.offset, $0.element!)
        }
        self.init(annotations, id: \.0, content: \.1)
    }

    func _visit(_ visitor: MapContentVisitor) {
        let group = AnnotationGroup(
            prefixId: visitor.id,
            layerId: layerId,
            layerPosition: layerPosition,
            store: store,
            make: { $0.makeCircleAnnotationManager(id: $1, layerPosition: $2) },
            updateProperties: { self.updateProperties(manager: $0) })
        visitor.add(annotationGroup: group)
    }

    private func updateProperties(manager: CircleAnnotationManager) {
        assign(manager, \.slot, value: slot)
        assign(manager, \.circleEmissiveStrength, value: circleEmissiveStrength)
        assign(manager, \.circlePitchAlignment, value: circlePitchAlignment)
        assign(manager, \.circlePitchScale, value: circlePitchScale)
        assign(manager, \.circleTranslate, value: circleTranslate)
        assign(manager, \.circleTranslateAnchor, value: circleTranslateAnchor)
        assign(manager, \.slot, value: slot)
    }

    // MARK: - Common layer properties

    private var circleEmissiveStrength: Double?
    /// Controls the intensity of light emitted on the source features. This property works only with 3D light, i.e. when `lights` root property is defined.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func circleEmissiveStrength(_ newValue: Double) -> Self {
        with(self, setter(\.circleEmissiveStrength, newValue))
    }

    private var circlePitchAlignment: CirclePitchAlignment?
    /// Orientation of circle when map is pitched.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func circlePitchAlignment(_ newValue: CirclePitchAlignment) -> Self {
        with(self, setter(\.circlePitchAlignment, newValue))
    }

    private var circlePitchScale: CirclePitchScale?
    /// Controls the scaling behavior of the circle when the map is pitched.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func circlePitchScale(_ newValue: CirclePitchScale) -> Self {
        with(self, setter(\.circlePitchScale, newValue))
    }

    private var circleTranslate: [Double]?
    /// The geometry's offset. Values are [x, y] where negatives indicate left and up, respectively.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func circleTranslate(_ newValue: [Double]) -> Self {
        with(self, setter(\.circleTranslate, newValue))
    }

    private var circleTranslateAnchor: CircleTranslateAnchor?
    /// Controls the frame of reference for `circle-translate`.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func circleTranslateAnchor(_ newValue: CircleTranslateAnchor) -> Self {
        with(self, setter(\.circleTranslateAnchor, newValue))
    }

    private var slot: String?
    /// 
    /// Slot for the underlying layer.
    ///
    /// Use this property to position the annotations relative to other map features if you use Mapbox Standard Style.
    /// See <doc:Migrate-to-v11##21-The-Mapbox-Standard-Style> for more info.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func slot(_ newValue: String) -> Self {
        with(self, setter(\.slot, newValue))
    }


    private var layerPosition: LayerPosition?

    /// Defines relative position of the layers drawing the annotations managed by the current group.
    ///
    /// - NOTE: Layer position isn't updatable. Only the first value passed to this function set will take effect.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func layerPosition(_ newValue: LayerPosition) -> Self {
        with(self, setter(\.layerPosition, newValue))
    }

    private var layerId: String?

    /// Specifies identifier for underlying implementation layer.
    ///
    /// Use the identifier in ``layerPosition(_:)``, or to create view annotations bound the annotations from the group.
    /// For more information, see the ``MapViewAnnotation/init(layerId:featureId:content:)``.
#if swift(>=5.8)
    @_documentation(visibility: public)
#endif
    public func layerId(_ layerId: String) -> Self {
        with(self, setter(\.layerId, layerId))
    }
}

extension CircleAnnotation: PrimitiveMapContent, MapContentAnnotation {
    func _visit(_ visitor: MapContentVisitor) {
        CircleAnnotationGroup { self }
            ._visit(visitor)
    }
}

extension CircleAnnotationManager: MapContentAnnotationManager {}

// End of generated file.
