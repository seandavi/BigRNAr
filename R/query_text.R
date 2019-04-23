quantsByStudy = '
query bigRnaByStudies($studyids: [String!] = []) {
  allBigrnaGeneQuants(filter: { studyAccession: { in: $studyids } }) {
    nodes {
      accession
      filesize
      filename
      ctime
      sampleAccession
      studyAccession
      uuid
      key
    }
    pageInfo {
      startCursor
      endCursor
      hasNextPage
    }
  }
}
'

metadataFullTextSearch = '
query fullTextMetadataSearch (
  $match: String!=""
) {
  allMetadata(filter: {textsearchableIndexCol: {matches: $match}}) {
    edges {
      node {
        sampAccession
        sampAlias
        sampBioSample
        sampBrokerName
        sampCenterName
        sampDescription
        sampGsm
        sampIdentifiers
        sampOrganism
        sampTitle
        sampTaxonId
        sampXrefs
        sampStatus
        sampUpdated
        sampPublished
        sampReceived
        sampVisibility
        sampReplacedBy
        sampStudyAccession
        exptAlias
        exptAttributes
        exptBrokerName
        exptCenterName
        exptDescription
        exptDesign
        exptIdentifiers
        exptInstrumentModel
        exptLibraryConstructionProtocol
        exptLibraryLayoutLength
        exptLibraryLayoutOrientation
        exptLibraryLayoutSdev
        exptLibraryName
        exptLibraryStrategy
        exptLibrarySource
        exptLibraryLayout
        exptLibrarySelection
        exptPlatform
        exptSampleAccession
        exptStudyAccession
        exptTitle
        exptXrefs
        exptStatus
        exptUpdated
        exptPublished
        exptReceived
        exptVisibility
        exptReplacedBy
      }
    }
    pageInfo{
      hasNextPage
      endCursor
    }
    totalCount
  }
}
'

studyFullTextSearch = '
query studyFullTextSearch (
  $match: String!=""
) {
  allStudies(filter: {textsearchableIndexCol: {matches: $match}}) {
    edges {
      node {
        accession
        bioproject
        gse
        abstract
        alias
        attributes
        brokerName
        centerName
        description
        identifiers
        studyType
        title
        xrefs
        status
        updated
        published
        received
        visibility
        replacedBy
        metadataByExptStudyAccession {
          nodes {
            sampAccession
            exptAccession
            sampTitle
            exptLibraryStrategy
            exptLibrarySelection
          }
          totalCount
        }
      }
    }
    pageInfo {
      hasNextPage
      endCursor
    }
    totalCount
  }
}
'
