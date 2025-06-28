// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i6;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i8;
import 'package:trading_sample_app/app/models/asset_model.dart' as _i7;
import 'package:trading_sample_app/ui/views/market/market_view.dart' as _i4;
import 'package:trading_sample_app/ui/views/order/order_view.dart' as _i3;
import 'package:trading_sample_app/ui/views/portfolio/portfolio_view.dart'
    as _i5;
import 'package:trading_sample_app/ui/views/root/root_view.dart' as _i2;

class Routes {
  static const rootView = '/';

  static const orderView = 'orderView';

  static const marketView = 'marketView';

  static const portfolioView = 'PortfolioView';

  static const all = <String>{
    rootView,
    orderView,
    marketView,
    portfolioView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.rootView,
      page: _i2.RootView,
    ),
    _i1.RouteDef(
      Routes.orderView,
      page: _i3.OrderView,
    ),
    _i1.RouteDef(
      Routes.marketView,
      page: _i4.MarketView,
    ),
    _i1.RouteDef(
      Routes.portfolioView,
      page: _i5.PortfolioView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.RootView: (data) {
      final args = data.getArgs<RootViewArguments>(
        orElse: () => const RootViewArguments(),
      );
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i2.RootView(key: args.key, pageIndex: args.pageIndex),
        settings: data,
      );
    },
    _i3.OrderView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.OrderView(),
        settings: data,
      );
    },
    _i4.MarketView: (data) {
      final args = data.getArgs<MarketViewArguments>(nullOk: false);
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.MarketView(key: args.key, asset: args.asset),
        settings: data,
      );
    },
    _i5.PortfolioView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.PortfolioView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class RootViewArguments {
  const RootViewArguments({
    this.key,
    this.pageIndex = 0,
  });

  final _i6.Key? key;

  final int pageIndex;

  @override
  String toString() {
    return '{"key": "$key", "pageIndex": "$pageIndex"}';
  }

  @override
  bool operator ==(covariant RootViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.pageIndex == pageIndex;
  }

  @override
  int get hashCode {
    return key.hashCode ^ pageIndex.hashCode;
  }
}

class MarketViewArguments {
  const MarketViewArguments({
    this.key,
    required this.asset,
  });

  final _i6.Key? key;

  final _i7.AssetModel asset;

  @override
  String toString() {
    return '{"key": "$key", "asset": "$asset"}';
  }

  @override
  bool operator ==(covariant MarketViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.asset == asset;
  }

  @override
  int get hashCode {
    return key.hashCode ^ asset.hashCode;
  }
}

extension NavigatorStateExtension on _i8.NavigationService {
  Future<dynamic> navigateToRootView({
    _i6.Key? key,
    int pageIndex = 0,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.rootView,
        arguments: RootViewArguments(key: key, pageIndex: pageIndex),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.orderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMarketView({
    _i6.Key? key,
    required _i7.AssetModel asset,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.marketView,
        arguments: MarketViewArguments(key: key, asset: asset),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPortfolioView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.portfolioView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRootView({
    _i6.Key? key,
    int pageIndex = 0,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.rootView,
        arguments: RootViewArguments(key: key, pageIndex: pageIndex),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrderView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.orderView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMarketView({
    _i6.Key? key,
    required _i7.AssetModel asset,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.marketView,
        arguments: MarketViewArguments(key: key, asset: asset),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPortfolioView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.portfolioView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
