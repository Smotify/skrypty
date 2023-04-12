function installSkrypty()
    local url = "https://codeload.github.com/Smotify/skrypty/zip/master"
    local zipFile = getMudletHomeDir() .. "/skrypty.zip"
    local unzipDir = getMudletHomeDir() .. "/skrypty-master/"
    registerAnonymousEventHandler("sysDownloadDone", function(_, filename)
        if filename == zipFile then
            registerAnonymousEventHandler("sysUnzipDone", function()
                os.remove(zipFile)
                os.rename(unzipDir .. "/skrypty", getMudletHomeDir() .. "/skrypty/")
                installPackage(getMudletHomeDir() .. "/skrypty/Smotify.xml")
                if not saveProfile() then
                    tempTimer(5, function() saveProfile() end)
                end
                cecho("\n&lt;CadetBlue&gt;(skrypty)&lt;tomato&gt;: Skrypty zainstalowane\n")
            end)
            registerAnonymousEventHandler("sysUnzipError", function()
                cecho("\n&lt;CadetBlue&gt;(skrypty)&lt;tomato&gt;: Blad podczas rozpakowywania skryptow\n")
            end)
            unzipAsync(zipFile, getMudletHomeDir())
        end
    end)
    registerAnonymousEventHandler("sysDownloadError", function(_, errorFound)
        cecho("\n&lt;CadetBlue&gt;(skrypty)&lt;tomato&gt;: Blad podczas pobierania skryptow: " .. errorFound .. "\n")
    end)
    downloadFile(zipFile, url)
end
