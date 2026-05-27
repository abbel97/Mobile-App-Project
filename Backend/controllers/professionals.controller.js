const { query, run } = require('../database');

function mapProfessional(row) {
	if (!row) return row;

	return {
		...row,
		bio: row.bio || '',
		location: row.location || '',
		experience_years: row.experience_years || 0,
		service_rate: row.service_rate || 0,
		education_level: row.education_level || '',
	};
}

function listProfessionals(req, res) {
	try {
		const professionals = query('SELECT * FROM professionals ORDER BY updated_at DESC');
		return res.json(professionals.map(mapProfessional));
	} catch {
		return res.status(500).json({ message: 'Server error' });
	}
}

function getProfessionalById(req, res) {
	try {
		const rows = query('SELECT * FROM professionals WHERE id = ?', [req.params.professionalId]);
		if (rows.length === 0) {
			return res.status(404).json({ message: 'Professional not found' });
		}

		return res.json(mapProfessional(rows[0]));
	} catch {
		return res.status(500).json({ message: 'Server error' });
	}
}

function getMyProfile(req, res) {
	try {
		const rows = query('SELECT * FROM professionals WHERE user_id = ?', [req.user.id]);
		if (rows.length === 0) {
			return res.status(404).json({ message: 'Professional profile not found' });
		}

		return res.json(mapProfessional(rows[0]));
	} catch {
		return res.status(500).json({ message: 'Server error' });
	}
}

function updateMyProfile(req, res) {
	try {
		const rows = query('SELECT * FROM professionals WHERE user_id = ?', [req.user.id]);
		if (rows.length === 0) {
			return res.status(404).json({ message: 'Professional profile not found' });
		}

		const current = rows[0];
		const now = new Date().toISOString();
		const {
			profession,
			bio,
			location,
			experience_years,
			service_rate,
			education_level,
		} = req.body;

		const nextProfession = profession?.trim() || current.profession;
		const nextBio = bio ?? current.bio ?? '';
		const nextLocation = location ?? current.location ?? '';
		const nextExperienceYears = experience_years === undefined || experience_years === ''
			? current.experience_years || 0
			: Number(experience_years);
		const nextServiceRate = service_rate === undefined || service_rate === ''
			? current.service_rate || 0
			: Number(service_rate);
		const nextEducationLevel = education_level ?? current.education_level ?? '';

		if (!nextProfession) {
			return res.status(400).json({ message: 'Profession is required' });
		}

		run(
			`UPDATE professionals
				 SET profession = ?, bio = ?, location = ?, experience_years = ?,
						 service_rate = ?, education_level = ?, updated_at = ?
			 WHERE user_id = ?`,
			[
				nextProfession,
				nextBio,
				nextLocation,
				Number.isNaN(nextExperienceYears) ? 0 : nextExperienceYears,
				Number.isNaN(nextServiceRate) ? 0 : nextServiceRate,
				nextEducationLevel,
				now,
				req.user.id,
			]
		);

		return res.json(mapProfessional(query('SELECT * FROM professionals WHERE user_id = ?', [req.user.id])[0]));
	} catch {
		return res.status(500).json({ message: 'Server error' });
	}
}

module.exports = {
	listProfessionals,
	getProfessionalById,
	getMyProfile,
	updateMyProfile,
};
