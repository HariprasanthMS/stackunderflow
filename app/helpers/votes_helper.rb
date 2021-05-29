module VotesHelper
  def getUpvoteCount(answer)
    answer.votes.where(vote_type: "upvote").count
  end

  def getDownvoteCount(answer)
    answer.votes.where(vote_type: "downvote").count
  end
end
