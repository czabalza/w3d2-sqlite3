class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(self_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, self_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    User.new(results.first)
  end

  def self.find_by_name(first_name, last_name)
    users = QuestionsDatabase.instance.execute(<<-SQL, first_name, last_name)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    users.map { |user| User.new(user) }
  end

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def fullname
    "#{fname} #{lname}"
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def save
    if id == nil
      users = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO
          users
          (fname, lname)
        VALUES
          (?, ?)
      SQL
    else
      users = QuestionsDatabase.instance.execute(<<-SQL, fname, lname, id)
        UPDATE
          users
        SET
          fname = ?,
          lname = ?
        WHERE
          id = ?
        SQL
    end
  end
end
