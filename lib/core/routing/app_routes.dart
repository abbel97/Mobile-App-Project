class AppRoutes {
	const AppRoutes._();

	static const splash = '/';
	static const home = '/home';

	static const login = '/auth/login';
	static const customerRegister = '/auth/customer-register';
	static const professionalRegister = '/auth/professional-register';
	static const forgotPassword = '/auth/forgot-password';
	static const changePassword = '/auth/change-password';

	static const customerDashboard = '/customer/dashboard';
  static const customerRequestSubmit = '/customer/request-submit';
	static const customerRequests = '/customer/requests';
	static const customerRequestEdit = '/customer/request-edit';
	static const customerProfileEdit = '/customer/profile-edit';
	static const customerSettings = '/customer/settings';

	static const professionalDashboard = '/professional/dashboard';
	static const jobs = '/professional/jobs';
	static const acceptedJobs = '/professional/accepted-jobs';
	static const jobDetails = '/professional/job-details/:jobId';
	static const professionalProfileEdit = '/professional/profile-edit';
	static const professionalSettings = '/professional/settings';

	static const professionalsList = '/professionals';
	static const professionalProfileDetail = '/professional-detail';
	static const notifications = '/notifications';
	static const termsAndPolicy = '/terms-policy';
}
