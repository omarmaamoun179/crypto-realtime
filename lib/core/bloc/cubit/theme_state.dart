enum ThemeStatus { light, dark }

extension ThemeStateX on ThemeState {
  bool get isLight => status == ThemeStatus.light;
  bool get isDark => status == ThemeStatus.dark;
}

class ThemeState {
  final ThemeStatus status;

  ThemeState({this.status = ThemeStatus.light});

  ThemeState copyWith({
    ThemeStatus? status,
  }) {
    return ThemeState(
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(covariant ThemeState other) {
    if (identical(this, other)) return true;

    return other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}
