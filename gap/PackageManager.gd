#
# PackageManager: Easily download and install GAP packages
#
# Declarations
#
#! @Chapter Commands

#! @Section Installing packages

#! @Description
#!   Attempts to download and install a package.  The argument <A>string</A>
#!   should be a string containing one of the following:
#!     * the name of a package;
#!     * the URL of a package archive, ending in <C>.tar.gz</C>;
#!     * the URL of a git repository, ending in <C>.git</C>;
#!     * the URL of a mercurial repository, ending in <C>.hg</C>;
#!     * the URL of a valid <C>PackageInfo.g</C> file.
#!
#!   The package will then be downloaded and installed in the user's pkg folder
#!   at <C>~/.gap/pkg</C>, if possible.  If this installation is successful,
#!   <K>true</K> is returned; otherwise, <K>false</K> is returned.  To see more
#!   information about this process while it is ongoing, see
#!   <C>InfoPackageManager</C>.
#!
#! @BeginExample
#! gap> InstallPackage("digraphs");
#! true
#! @EndExample
#!
#! @Arguments string
#! @Returns
#!   true or false
DeclareGlobalFunction("InstallPackage");

#! @Description
#!   Info class for the PackageManager package.  Set this to the following
#!   levels for different levels of information:
#!     * 0 - No messages
#!     * 1 - Problems only: messages describing what went wrong, with no
#!           messages if an operation is successful
#!     * 2 - Problems and directories: also displays directories that were used
#!           for package installation or removal
#!     * 3 - All: shows step-by-step progress of operations
#!
#!   Set this using, for example <C>SetInfoLevel(InfoPackageManager, 3)</C>.
#!   Default value is 1.
DeclareInfoClass("InfoPackageManager");
SetInfoLevel(InfoPackageManager, 1);

#! @Description
#!   Attempts to download and install a package given only its name.  Returns
#!   <K>true</K> if the installation was successful, and <K>false</K> otherwise.
#! @Arguments name
#! @Returns
#!   true or false
DeclareGlobalFunction("InstallPackageFromName");

#! @Description
#!   Attempts to download and install a package by downloading its PackageInfo.g
#!   from the specified URL.  Returns <K>true</K> if the installation was
#!   successful, and <K>false</K> otherwise.
#! @Arguments url
#! @Returns
#!   true or false
DeclareGlobalFunction("InstallPackageFromInfo");

#! @Description
#!   Attempts to download and install a package from an archive located at the
#!   given URL.  Returns <K>true</K> if the installation was successful, and
#!   <K>false</K> otherwise.
#! @Arguments url
#! @Returns
#!   true or false
DeclareGlobalFunction("InstallPackageFromArchive");

#! @Description
#!   Attempts to download and install a package from a git repository located at
#!   the given URL.  Returns <K>true</K> if the installation was successful, and
#!   <K>false</K> otherwise.
#! @Arguments url
#! @Returns
#!   true or false
DeclareGlobalFunction("InstallPackageFromGit");

#! @Description
#!   Attempts to download and install a package from a Mercurial repository
#!   located at the given URL.  Returns <K>true</K> if the installation was
#!   successful, and <K>false</K> otherwise.
#! @Arguments url
#! @Returns
#!   true or false
DeclareGlobalFunction("InstallPackageFromHg");

#! @Section Removing packages

#! @Description
#!   Attempts to remove an installed package using its name.  The first argument
#!   <A>name</A> should be a string specifying the name of a package installed
#!   in the user GAP root.  The second argument <A>interactive</A> is optional,
#!   and should be a boolean specifying whether to confirm interactively before
#!   any directories are deleted (default value <K>true</K>).
#!
#!   Returns <K>true</K> if the removal was successful, and <K>false</K>
#!   otherwise.
#!
#! @BeginExample
#! gap> RemovePackage("digraphs");
#! Really delete directory /home/user/.gap/pkg/digraphs-0.13.0 ? [y/N] y
#! true
#! @EndExample
#!
#! @Arguments name[, interactive]
#! @Returns
#!   true or false
DeclareGlobalFunction("RemovePackage");

DeclareGlobalFunction("GetPackageURLs");

# Hidden functions
DeclareGlobalFunction("PKGMAN_CheckPackage");
DeclareGlobalFunction("PKGMAN_CompileDir");
DeclareGlobalFunction("PKGMAN_Exec");
DeclareGlobalFunction("PKGMAN_NameOfGitRepo");
DeclareGlobalFunction("PKGMAN_NameOfHgRepo");
DeclareGlobalFunction("PKGMAN_PackageDir");
DeclareGlobalFunction("PKGMAN_RefreshPackageInfo");
DeclareGlobalFunction("PKGMAN_InsertPackageDirectory");
DeclareGlobalFunction("PKGMAN_SetCustomPackageDir");
DeclareGlobalFunction("PKGMAN_DownloadURL");

# Hidden variables
PKGMAN_CustomPackageDir := "";
PKGMAN_PackageInfoURLList :=
  Concatenation("https://raw.githubusercontent.com/gap-system/",
                "gap-distribution/master/DistributionUpdate/",
                "PackageUpdate/currentPackageInfoURLList");
PKGMAN_DownloadCmds := [ [ "wget", ["--quiet", "-O", "-"] ],
                         [ "curl", ["--silent", "-L", "--output", "-"] ] ];
