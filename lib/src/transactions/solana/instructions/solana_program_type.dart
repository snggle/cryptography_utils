enum SolanaProgramType {
  system('11111111111111111111111111111111'),
  token('TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA'),
  computeBudget('ComputeBudget111111111111111111111111111111'),
  stake('Stake11111111111111111111111111111111111111');

  const SolanaProgramType(this.value);

  final String value;

  static SolanaProgramType? fromProgramId(String programId) {
    for (SolanaProgramType solanaProgramType in SolanaProgramType.values) {
      if (solanaProgramType.value == programId) {
        return solanaProgramType;
      }
    }
    return null;
  }
}
