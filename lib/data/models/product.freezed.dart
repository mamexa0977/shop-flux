// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  @JsonKey(fromJson: stringToInt)
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToDouble)
  double get price => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToDoubleNullable)
  double? get discountPrice => throw _privateConstructorUsedError;
  String? get sku => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToIntNullable)
  int? get stock => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;
  String? get dimensions => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  bool? get isFeatured => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToIntNullable)
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'seller')
  User? get seller => throw _privateConstructorUsedError;
  @JsonKey(name: 'ProductImages')
  List<ProductImage>? get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'ProductVariants')
  List<ProductVariant>? get variants => throw _privateConstructorUsedError;
  @JsonKey(name: 'Reviews')
  List<Review>? get reviews => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    @JsonKey(fromJson: stringToInt) int id,
    String name,
    String? description,
    @JsonKey(fromJson: stringToDouble) double price,
    @JsonKey(fromJson: stringToDoubleNullable) double? discountPrice,
    String? sku,
    @JsonKey(fromJson: stringToIntNullable) int? stock,
    String? brand,
    double? weight,
    String? dimensions,
    bool? isActive,
    bool? isFeatured,
    @JsonKey(fromJson: stringToIntNullable) int? categoryId,
    @JsonKey(name: 'seller') User? seller,
    @JsonKey(name: 'ProductImages') List<ProductImage>? images,
    @JsonKey(name: 'ProductVariants') List<ProductVariant>? variants,
    @JsonKey(name: 'Reviews') List<Review>? reviews,
  });

  $UserCopyWith<$Res>? get seller;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? discountPrice = freezed,
    Object? sku = freezed,
    Object? stock = freezed,
    Object? brand = freezed,
    Object? weight = freezed,
    Object? dimensions = freezed,
    Object? isActive = freezed,
    Object? isFeatured = freezed,
    Object? categoryId = freezed,
    Object? seller = freezed,
    Object? images = freezed,
    Object? variants = freezed,
    Object? reviews = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            price:
                null == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as double,
            discountPrice:
                freezed == discountPrice
                    ? _value.discountPrice
                    : discountPrice // ignore: cast_nullable_to_non_nullable
                        as double?,
            sku:
                freezed == sku
                    ? _value.sku
                    : sku // ignore: cast_nullable_to_non_nullable
                        as String?,
            stock:
                freezed == stock
                    ? _value.stock
                    : stock // ignore: cast_nullable_to_non_nullable
                        as int?,
            brand:
                freezed == brand
                    ? _value.brand
                    : brand // ignore: cast_nullable_to_non_nullable
                        as String?,
            weight:
                freezed == weight
                    ? _value.weight
                    : weight // ignore: cast_nullable_to_non_nullable
                        as double?,
            dimensions:
                freezed == dimensions
                    ? _value.dimensions
                    : dimensions // ignore: cast_nullable_to_non_nullable
                        as String?,
            isActive:
                freezed == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool?,
            isFeatured:
                freezed == isFeatured
                    ? _value.isFeatured
                    : isFeatured // ignore: cast_nullable_to_non_nullable
                        as bool?,
            categoryId:
                freezed == categoryId
                    ? _value.categoryId
                    : categoryId // ignore: cast_nullable_to_non_nullable
                        as int?,
            seller:
                freezed == seller
                    ? _value.seller
                    : seller // ignore: cast_nullable_to_non_nullable
                        as User?,
            images:
                freezed == images
                    ? _value.images
                    : images // ignore: cast_nullable_to_non_nullable
                        as List<ProductImage>?,
            variants:
                freezed == variants
                    ? _value.variants
                    : variants // ignore: cast_nullable_to_non_nullable
                        as List<ProductVariant>?,
            reviews:
                freezed == reviews
                    ? _value.reviews
                    : reviews // ignore: cast_nullable_to_non_nullable
                        as List<Review>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get seller {
    if (_value.seller == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.seller!, (value) {
      return _then(_value.copyWith(seller: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: stringToInt) int id,
    String name,
    String? description,
    @JsonKey(fromJson: stringToDouble) double price,
    @JsonKey(fromJson: stringToDoubleNullable) double? discountPrice,
    String? sku,
    @JsonKey(fromJson: stringToIntNullable) int? stock,
    String? brand,
    double? weight,
    String? dimensions,
    bool? isActive,
    bool? isFeatured,
    @JsonKey(fromJson: stringToIntNullable) int? categoryId,
    @JsonKey(name: 'seller') User? seller,
    @JsonKey(name: 'ProductImages') List<ProductImage>? images,
    @JsonKey(name: 'ProductVariants') List<ProductVariant>? variants,
    @JsonKey(name: 'Reviews') List<Review>? reviews,
  });

  @override
  $UserCopyWith<$Res>? get seller;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? discountPrice = freezed,
    Object? sku = freezed,
    Object? stock = freezed,
    Object? brand = freezed,
    Object? weight = freezed,
    Object? dimensions = freezed,
    Object? isActive = freezed,
    Object? isFeatured = freezed,
    Object? categoryId = freezed,
    Object? seller = freezed,
    Object? images = freezed,
    Object? variants = freezed,
    Object? reviews = freezed,
  }) {
    return _then(
      _$ProductImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        price:
            null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as double,
        discountPrice:
            freezed == discountPrice
                ? _value.discountPrice
                : discountPrice // ignore: cast_nullable_to_non_nullable
                    as double?,
        sku:
            freezed == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                    as String?,
        stock:
            freezed == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                    as int?,
        brand:
            freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                    as String?,
        weight:
            freezed == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                    as double?,
        dimensions:
            freezed == dimensions
                ? _value.dimensions
                : dimensions // ignore: cast_nullable_to_non_nullable
                    as String?,
        isActive:
            freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool?,
        isFeatured:
            freezed == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                    as bool?,
        categoryId:
            freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                    as int?,
        seller:
            freezed == seller
                ? _value.seller
                : seller // ignore: cast_nullable_to_non_nullable
                    as User?,
        images:
            freezed == images
                ? _value._images
                : images // ignore: cast_nullable_to_non_nullable
                    as List<ProductImage>?,
        variants:
            freezed == variants
                ? _value._variants
                : variants // ignore: cast_nullable_to_non_nullable
                    as List<ProductVariant>?,
        reviews:
            freezed == reviews
                ? _value._reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                    as List<Review>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl({
    @JsonKey(fromJson: stringToInt) required this.id,
    required this.name,
    this.description,
    @JsonKey(fromJson: stringToDouble) required this.price,
    @JsonKey(fromJson: stringToDoubleNullable) this.discountPrice,
    this.sku,
    @JsonKey(fromJson: stringToIntNullable) this.stock,
    this.brand,
    this.weight,
    this.dimensions,
    this.isActive,
    this.isFeatured,
    @JsonKey(fromJson: stringToIntNullable) this.categoryId,
    @JsonKey(name: 'seller') this.seller,
    @JsonKey(name: 'ProductImages') final List<ProductImage>? images,
    @JsonKey(name: 'ProductVariants') final List<ProductVariant>? variants,
    @JsonKey(name: 'Reviews') final List<Review>? reviews,
  }) : _images = images,
       _variants = variants,
       _reviews = reviews;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  @JsonKey(fromJson: stringToInt)
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(fromJson: stringToDouble)
  final double price;
  @override
  @JsonKey(fromJson: stringToDoubleNullable)
  final double? discountPrice;
  @override
  final String? sku;
  @override
  @JsonKey(fromJson: stringToIntNullable)
  final int? stock;
  @override
  final String? brand;
  @override
  final double? weight;
  @override
  final String? dimensions;
  @override
  final bool? isActive;
  @override
  final bool? isFeatured;
  @override
  @JsonKey(fromJson: stringToIntNullable)
  final int? categoryId;
  @override
  @JsonKey(name: 'seller')
  final User? seller;
  final List<ProductImage>? _images;
  @override
  @JsonKey(name: 'ProductImages')
  List<ProductImage>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProductVariant>? _variants;
  @override
  @JsonKey(name: 'ProductVariants')
  List<ProductVariant>? get variants {
    final value = _variants;
    if (value == null) return null;
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Review>? _reviews;
  @override
  @JsonKey(name: 'Reviews')
  List<Review>? get reviews {
    final value = _reviews;
    if (value == null) return null;
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, discountPrice: $discountPrice, sku: $sku, stock: $stock, brand: $brand, weight: $weight, dimensions: $dimensions, isActive: $isActive, isFeatured: $isFeatured, categoryId: $categoryId, seller: $seller, images: $images, variants: $variants, reviews: $reviews)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.discountPrice, discountPrice) ||
                other.discountPrice == discountPrice) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.dimensions, dimensions) ||
                other.dimensions == dimensions) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.seller, seller) || other.seller == seller) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    price,
    discountPrice,
    sku,
    stock,
    brand,
    weight,
    dimensions,
    isActive,
    isFeatured,
    categoryId,
    seller,
    const DeepCollectionEquality().hash(_images),
    const DeepCollectionEquality().hash(_variants),
    const DeepCollectionEquality().hash(_reviews),
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product implements Product {
  const factory _Product({
    @JsonKey(fromJson: stringToInt) required final int id,
    required final String name,
    final String? description,
    @JsonKey(fromJson: stringToDouble) required final double price,
    @JsonKey(fromJson: stringToDoubleNullable) final double? discountPrice,
    final String? sku,
    @JsonKey(fromJson: stringToIntNullable) final int? stock,
    final String? brand,
    final double? weight,
    final String? dimensions,
    final bool? isActive,
    final bool? isFeatured,
    @JsonKey(fromJson: stringToIntNullable) final int? categoryId,
    @JsonKey(name: 'seller') final User? seller,
    @JsonKey(name: 'ProductImages') final List<ProductImage>? images,
    @JsonKey(name: 'ProductVariants') final List<ProductVariant>? variants,
    @JsonKey(name: 'Reviews') final List<Review>? reviews,
  }) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  @JsonKey(fromJson: stringToInt)
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(fromJson: stringToDouble)
  double get price;
  @override
  @JsonKey(fromJson: stringToDoubleNullable)
  double? get discountPrice;
  @override
  String? get sku;
  @override
  @JsonKey(fromJson: stringToIntNullable)
  int? get stock;
  @override
  String? get brand;
  @override
  double? get weight;
  @override
  String? get dimensions;
  @override
  bool? get isActive;
  @override
  bool? get isFeatured;
  @override
  @JsonKey(fromJson: stringToIntNullable)
  int? get categoryId;
  @override
  @JsonKey(name: 'seller')
  User? get seller;
  @override
  @JsonKey(name: 'ProductImages')
  List<ProductImage>? get images;
  @override
  @JsonKey(name: 'ProductVariants')
  List<ProductVariant>? get variants;
  @override
  @JsonKey(name: 'Reviews')
  List<Review>? get reviews;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
