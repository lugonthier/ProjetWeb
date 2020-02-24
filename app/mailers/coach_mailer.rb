class CoachMailer < ApplicationMailer

    def confirm(coach)
        @coach = coach
        mail(to: coach.email, subject: 'Votre inscription sur TrainingOrga' + Rails.application.config.site[:name])
    end
end
