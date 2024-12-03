local Translations = {
    info = {
        search = 'Breaking in..',
    },
    error = {
        cooldown = 'You have to wait %{time} seconds to break in again',
        hasBeenSearched = "This Parking Meter has already been broken into!",
        nothingFound = "You didn't got any money!",
    },
    progressbar = {
        searching = "Breaking into Parking Meter..",
    },
    reward = {
        money = "You got $%{amount}",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
