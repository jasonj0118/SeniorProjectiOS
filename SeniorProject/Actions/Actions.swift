import ReSwift

// Admin Actions
struct SetLoggedInUserAction: Action {
    let user: User
}

/* Fetching Queue Information */
struct FetchedJoinedQueuesAction: Action {
    let joinedQueues: [Queue]
}

struct FetchedSelectedQueueAction: Action {
    let selectedQueue: Queue
}

struct FetchedPlayingQueueAction: Action {
    let playingQueue: Queue
}

struct FetchedSpotifySearchResultsAction: Action {
    let spotifySearchResults: [SpotifySong]
}

/* Updated which Queue is being VIEWED */
struct SetSelectedQueueAction: Action {
    let selectedQueue: Queue
}

struct UpdateSelectedQueueAction: Action {
    let queue: Queue
}

/* Update which Queue is being Played */
struct SetSelectedQueueAsPlayingQueue: Action {}

struct SetPlayingQueueAction: Action {
    let playingQueue: Queue?
}

struct SetPlayingQueueToNilAction: Action {}

struct AddSongToSelectedQueueAction: Action {
    let songToAdd: Song
}

struct RemoveSongFromSelectedQueueAction: Action {
    let songId: Int
}

struct SetQueueIsPlayingAction: Action {
    let isPlaying: Bool
}

/* Queue Manipulation Actions */
struct RestartCurrentSongAction: Action {}

struct SkipCurrentSongAction: Action {}

struct TogglePlaybackAction: Action {}

struct StopPlaybackAction: Action {}
struct ResetMusicPlayerStateAction: Action {}

/* Song playback Actions */
struct UpdateCurrentSongPositionAction: Action {
    let updatedTime: Double
}

struct UpdateCurrentSongDurationAction: Action {
    let updatedDuration: Double
}

struct UpdateSliderPositionAction: Action {
    let sliderValue: Double
}

struct SetHasSliderChangedAction: Action {
    let hasSliderChanged: Bool
}
