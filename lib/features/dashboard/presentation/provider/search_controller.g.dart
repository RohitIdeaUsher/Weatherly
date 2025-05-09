// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchControllerHash() => r'46b8ca23d9fb8ce341f4cffa2d59ac92e300ec16';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SearchController
    extends BuildlessAutoDisposeAsyncNotifier<List<Prediction>> {
  late final String query;

  FutureOr<List<Prediction>> build({
    required String query,
  });
}

/// See also [SearchController].
@ProviderFor(SearchController)
const searchControllerProvider = SearchControllerFamily();

/// See also [SearchController].
class SearchControllerFamily extends Family<AsyncValue<List<Prediction>>> {
  /// See also [SearchController].
  const SearchControllerFamily();

  /// See also [SearchController].
  SearchControllerProvider call({
    required String query,
  }) {
    return SearchControllerProvider(
      query: query,
    );
  }

  @override
  SearchControllerProvider getProviderOverride(
    covariant SearchControllerProvider provider,
  ) {
    return call(
      query: provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchControllerProvider';
}

/// See also [SearchController].
class SearchControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    SearchController, List<Prediction>> {
  /// See also [SearchController].
  SearchControllerProvider({
    required String query,
  }) : this._internal(
          () => SearchController()..query = query,
          from: searchControllerProvider,
          name: r'searchControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchControllerHash,
          dependencies: SearchControllerFamily._dependencies,
          allTransitiveDependencies:
              SearchControllerFamily._allTransitiveDependencies,
          query: query,
        );

  SearchControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  FutureOr<List<Prediction>> runNotifierBuild(
    covariant SearchController notifier,
  ) {
    return notifier.build(
      query: query,
    );
  }

  @override
  Override overrideWith(SearchController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchControllerProvider._internal(
        () => create()..query = query,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SearchController, List<Prediction>>
      createElement() {
    return _SearchControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchControllerProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Prediction>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SearchController,
        List<Prediction>> with SearchControllerRef {
  _SearchControllerProviderElement(super.provider);

  @override
  String get query => (origin as SearchControllerProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
