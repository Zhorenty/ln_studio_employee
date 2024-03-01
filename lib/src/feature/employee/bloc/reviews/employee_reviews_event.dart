/// Business Logic Component EmployeeReviews_event Events
sealed class EmployeeReviewsEvent {
  const EmployeeReviewsEvent();

  /// Fetch
  const factory EmployeeReviewsEvent.fetchReviews(int employeeId) =
      EmployeeReviewsEvent$FetchReviews;
}

/// Fetch all EmployeeReviewss.
class EmployeeReviewsEvent$FetchReviews extends EmployeeReviewsEvent {
  const EmployeeReviewsEvent$FetchReviews(this.employeeId);

  final int employeeId;
}
