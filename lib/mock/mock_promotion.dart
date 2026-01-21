// 📁 lib/mock/mock_promotion.dart

// 👇 This will later be replaced by backend API
final Map<String, List<Map<String, String>>> mockPromotions = {
  "IF6K-A": [
    {"name": "Emma Johnson", "from": "SEM 5", "to": "SEM 6"},
    {"name": "Liam Smith", "from": "SEM 5", "to": "SEM 6"},
  ],
  "IF6K-B": [
    {"name": "Olivia Brown", "from": "SEM 5", "to": "SEM 6"},
  ],
  "IF5K-A": [
    {"name": "Noah Davis", "from": "SEM 3", "to": "SEM 4"},
  ],
};

// 👇 Detained data
final Map<String, List<Map<String, String>>> mockDetained = {
  "IF6K-A": [
    {"name": "Noah Davis", "sem": "SEM 6"},
  ],
  "IF5K-B": [
    {"name": "Lucas Green", "sem": "SEM 4"},
    {"name": "Ethan Clark", "sem": "SEM 4"},
  ],
};
