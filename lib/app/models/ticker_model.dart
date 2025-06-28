class TickerModel {
  final String? eventType;
  final int? eventTime;
  final String? symbol;
  final double? priceChange;
  final double? priceChangePercent;
  final double? weightedAvgPrice;
  final double? firstTradeBeforeWindowPrice;
  final double? lastPrice;
  final double? lastQuantity;
  final double? bestBidPrice;
  final double? bestBidQty;
  final double? bestAskPrice;
  final double? bestAskQty;
  final double? openPrice;
  final double? highPrice;
  final double? lowPrice;
  final double? baseVolume;
  final double? quoteVolume;
  final int? openTime;
  final int? closeTime;
  final int? firstTradeId;
  final int? lastTradeId;
  final int? totalTrades;

  TickerModel({
    this.eventType,
    this.eventTime,
    this.symbol,
    this.priceChange,
    this.priceChangePercent,
    this.weightedAvgPrice,
    this.firstTradeBeforeWindowPrice,
    this.lastPrice,
    this.lastQuantity,
    this.bestBidPrice,
    this.bestBidQty,
    this.bestAskPrice,
    this.bestAskQty,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.baseVolume,
    this.quoteVolume,
    this.openTime,
    this.closeTime,
    this.firstTradeId,
    this.lastTradeId,
    this.totalTrades,
  });

  factory TickerModel.fromJson(Map<String, dynamic> json) {
    return TickerModel(
      eventType: json['e'] as String?,
      eventTime: json['E'] as int?,
      symbol: json['s'] as String?,
      priceChange: double.tryParse(json['p'] ?? ''),
      priceChangePercent: double.tryParse(json['P'] ?? ''),
      weightedAvgPrice: double.tryParse(json['w'] ?? ''),
      firstTradeBeforeWindowPrice: double.tryParse(json['x'] ?? ''),
      lastPrice: double.tryParse(json['c'] ?? ''),
      lastQuantity: double.tryParse(json['Q'] ?? ''),
      bestBidPrice: double.tryParse(json['b'] ?? ''),
      bestBidQty: double.tryParse(json['B'] ?? ''),
      bestAskPrice: double.tryParse(json['a'] ?? ''),
      bestAskQty: double.tryParse(json['A'] ?? ''),
      openPrice: double.tryParse(json['o'] ?? ''),
      highPrice: double.tryParse(json['h'] ?? ''),
      lowPrice: double.tryParse(json['l'] ?? ''),
      baseVolume: double.tryParse(json['v'] ?? ''),
      quoteVolume: double.tryParse(json['q'] ?? ''),
      openTime: json['O'] as int?,
      closeTime: json['C'] as int?,
      firstTradeId: json['F'] as int?,
      lastTradeId: json['L'] as int?,
      totalTrades: json['n'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'e': eventType,
      'E': eventTime,
      's': symbol,
      'p': priceChange,
      'P': priceChangePercent,
      'w': weightedAvgPrice,
      'x': firstTradeBeforeWindowPrice,
      'c': lastPrice,
      'Q': lastQuantity,
      'b': bestBidPrice,
      'B': bestBidQty,
      'a': bestAskPrice,
      'A': bestAskQty,
      'o': openPrice,
      'h': highPrice,
      'l': lowPrice,
      'v': baseVolume,
      'q': quoteVolume,
      'O': openTime,
      'C': closeTime,
      'F': firstTradeId,
      'L': lastTradeId,
      'n': totalTrades,
    };
  }
}
