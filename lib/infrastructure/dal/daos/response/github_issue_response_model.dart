class GithubIssueResponse {
  List<GithubIssueResponseModel> list = <GithubIssueResponseModel>[];

  GithubIssueResponse({
    this.list = const <GithubIssueResponseModel>[],
  });

  GithubIssueResponse.fromJson(dynamic json) {
    if (json is List) {
      list = json.map((e) => GithubIssueResponseModel.fromJson(e)).toList();
    }
    if (json is Map) {
      message = json['message'] ?? '';
    }
  }

  String message = 'Something went wrong';
}

class GithubIssueResponseModel {
  String? url;
  String? repositoryUrl;
  String? labelsUrl;
  String? commentsUrl;
  String? eventsUrl;
  String? htmlUrl;
  int? id;
  String? nodeId;
  int? number;
  String? title;
  User? user;
  List<Labels>? labels;
  String? state;
  bool? locked;
  int? comments;
  String? createdAt;
  String? updatedAt;
  dynamic closedAt;
  String? authorAssociation;
  dynamic activeLockReason;
  String? body;
  Reactions? reactions;
  String? timelineUrl;

  GithubIssueResponseModel(
      {this.url,
      this.repositoryUrl,
      this.labelsUrl,
      this.commentsUrl,
      this.eventsUrl,
      this.htmlUrl,
      this.id,
      this.nodeId,
      this.number,
      this.title,
      this.user,
      this.labels,
      this.state,
      this.locked,
      this.comments,
      this.createdAt,
      this.updatedAt,
      this.closedAt,
      this.authorAssociation,
      this.activeLockReason,
      this.body,
      this.reactions,
      this.timelineUrl});

  GithubIssueResponseModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    repositoryUrl = json['repository_url'];
    labelsUrl = json['labels_url'];
    commentsUrl = json['comments_url'];
    eventsUrl = json['events_url'];
    htmlUrl = json['html_url'];
    id = json['id'];
    nodeId = json['node_id'];
    number = json['number'];
    title = json['title'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    if (json['labels'] != null) {
      labels = <Labels>[];
      json['labels'].forEach((v) {
        labels?.add(Labels.fromJson(v));
      });
    }
    state = json['state'];
    locked = json['locked'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    closedAt = json['closed_at'];
    authorAssociation = json['author_association'];
    activeLockReason = json['active_lock_reason'];
    body = json['body'];
    reactions = json['reactions'] != null
        ? Reactions?.fromJson(json['reactions'])
        : null;
    timelineUrl = json['timeline_url'];
  }

  String get message => '$repositoryUrl#$number';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['repository_url'] = repositoryUrl;
    data['labels_url'] = labelsUrl;
    data['comments_url'] = commentsUrl;
    data['events_url'] = eventsUrl;
    data['html_url'] = htmlUrl;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['number'] = number;
    data['title'] = title;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    if (labels != null) {
      data['labels'] = labels?.map((v) => v.toJson()).toList();
    }
    data['state'] = state;
    data['locked'] = locked;
    data['comments'] = comments;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['closed_at'] = closedAt;
    data['author_association'] = authorAssociation;
    data['active_lock_reason'] = activeLockReason;
    data['body'] = body;
    if (reactions != null) {
      data['reactions'] = reactions?.toJson();
    }
    data['timeline_url'] = timelineUrl;
    return data;
  }
}

class User {
  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;

  User(
      {this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionsUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.siteAdmin});

  User.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['avatar_url'] = avatarUrl;
    data['gravatar_id'] = gravatarId;
    data['url'] = url;
    data['html_url'] = htmlUrl;
    data['followers_url'] = followersUrl;
    data['following_url'] = followingUrl;
    data['gists_url'] = gistsUrl;
    data['starred_url'] = starredUrl;
    data['subscriptions_url'] = subscriptionsUrl;
    data['organizations_url'] = organizationsUrl;
    data['repos_url'] = reposUrl;
    data['events_url'] = eventsUrl;
    data['received_events_url'] = receivedEventsUrl;
    data['type'] = type;
    data['site_admin'] = siteAdmin;
    return data;
  }
}

class Labels {
  int? id;
  String? nodeId;
  String? url;
  String? name;
  String? color;
  String? description;

  Labels(
      {this.id,
      this.nodeId,
      this.url,
      this.name,
      this.color,
      this.description});

  Labels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    url = json['url'];
    name = json['name'];
    color = json['color'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['node_id'] = nodeId;
    data['url'] = url;
    data['name'] = name;
    data['color'] = color;
    data['description'] = description;
    return data;
  }
}

class Reactions {
  String? url;
  int? totalCount;
  int? laugh;
  int? hooray;
  int? confused;
  int? heart;
  int? rocket;
  int? eyes;

  Reactions(
      {this.url,
      this.totalCount,
      this.laugh,
      this.hooray,
      this.confused,
      this.heart,
      this.rocket,
      this.eyes});

  Reactions.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    totalCount = json['total_count'];
    laugh = json['laugh'];
    hooray = json['hooray'];
    confused = json['confused'];
    heart = json['heart'];
    rocket = json['rocket'];
    eyes = json['eyes'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['total_count'] = totalCount;
    data['laugh'] = laugh;
    data['hooray'] = hooray;
    data['confused'] = confused;
    data['heart'] = heart;
    data['rocket'] = rocket;
    data['eyes'] = eyes;
    return data;
  }
}
